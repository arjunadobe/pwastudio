const {
    loadEnvironment,
    WebpackTools: {
        RootComponentsPlugin,
        ServiceWorkerPlugin,
        MagentoResolver,
        UpwardPlugin,
        PWADevServer
    }
} = require('@magento/pwa-buildpack');

const projectConfig = loadEnvironment(__dirname);

const path = require('path');
const parentTheme = path.resolve(
    process.cwd() + '/../../pwa-studio/packages/venia-concept'
);



const webpack = require('webpack');

const TerserPlugin = require('terser-webpack-plugin');
const WebpackAssetsManifest = require('webpack-assets-manifest');

const themePaths = {
    images: path.resolve(__dirname, 'images'),
    templates: path.resolve(__dirname, 'templates'),
    src: path.resolve(__dirname, 'src'),
    output: path.resolve(__dirname, 'dist')
};

const rootComponentsDirs = [
    path.resolve(parentTheme, 'src/RootComponents/'),
    './src/RootComponents/'
];

const libs = [
    'apollo-cache-inmemory',
    'apollo-cache-persist',
    'apollo-client',
    'apollo-link-context',
    'apollo-link-http',
    'informed',
    'react',
    'react-apollo',
    'react-dom',
    'react-feather',
    'react-redux',
    'react-router-dom',
    'redux',
    'redux-actions',
    'redux-thunk'
];

module.exports = async function(env = {}) {
    const mode =
        env.mode || (projectConfig.isProd ? 'production' : 'development');

    const config = {
        mode,
        context: __dirname, // Node global for the running script's directory
        entry: {
            client: path.resolve(themePaths.src, 'index.js')
        },
        output: {
            path: themePaths.output,
            publicPath: '/',
            filename: 'js/[name].js',
            strictModuleExceptionHandling: true,
            chunkFilename: 'js/[name]-[chunkhash].js'
        },
        module: {
            rules: [
                {
                    test: /\.graphql$/,
                    exclude: /node_modules/,
                    use: [
                        {
                            loader: 'graphql-tag/loader'
                        }
                    ]
                },
                {
                    include: [themePaths.src, /peregrine/,path.resolve(parentTheme, 'src')],
                    test: /\.(mjs|js)$/,
                    use: [
                        {
                            loader: 'babel-loader',
                            options: {
                                cacheDirectory: true,
                                envName: mode,
                                rootMode: 'upward'
                            }
                        }
                    ]
                },
                {
                    test: /\.css$/,
                    exclude: /node_modules/,
                    use: [
                        'style-loader',
                        {
                            loader: 'css-loader',
                            options: {
                                importLoaders: 1,
                                localIdentName:
                                    '[name]-[local]-[hash:base64:3]',
                                modules: true
                            }
                        }
                    ]
                },
                {
                    test: /\.css$/,
                    include: /node_modules/,
                    use: [
                        'style-loader',
                        {
                            loader: 'css-loader',
                            options: {
                                importLoaders: 1,
                                modules: false
                            }
                        }
                    ]
                },
                {
                    test: /\.(jpg|svg)$/,
                    use: [
                        {
                            loader: 'file-loader',
                            options: {}
                        }
                    ]
                }
            ],
            // TODO: Replace this with whatever future configuration Webpack
            // will use to enforce errors on missing ES6 imports. Webpack
            // currently logs only warnings when ES6 imports are missing, and
            // this is the cleanest way to make those into real errors.
            strictExportPresence: true
        },
        resolve: await MagentoResolver.configure({
            paths: {
                root: __dirname
            }
        }),
        resolve: {
            modules: [__dirname, 'node_modules', parentTheme],
            mainFiles: ['index'],
            extensions: ['.mjs', '.js', '.json', '.graphql'],
            alias: {
                parentSrc: path.resolve(parentTheme, 'src'),
                parentComponents: path.resolve(parentTheme, 'src/components'),
                parentQueries: path.resolve(parentTheme, 'src/queries')
            }
        },
        plugins: [
            await new RootComponentsPlugin({
                rootComponentsDirs,
                context: __dirname
            }),
            new webpack.EnvironmentPlugin(projectConfig.env),
            new ServiceWorkerPlugin({
                mode,
                paths: themePaths,
                injectManifest: true,
                injectManifestConfig: {
                    include: [/\.js$/],
                    swSrc: path.resolve(parentTheme, 'src/sw.js'),
                    swDest: 'sw.js'
                }
            }),
            new WebpackAssetsManifest({
                output: 'asset-manifest.json',
                entrypoints: true,
                publicPath: '/',
                // Add explicit properties to the asset manifest for
                // venia-upward.yml to use when evaluating app shell templates.
                transform(assets) {
                    // All RootComponents go to prefetch, and all client scripts
                    // go to load.
                    assets.bundles = {
                        load: assets.entrypoints.client.js,
                        prefetch: []
                    };
                    Object.entries(assets).forEach(([name, value]) => {
                        if (name.startsWith('RootCmp')) {
                            const filenames = Array.isArray(value)
                                ? value
                                : [value];
                            assets.bundles.prefetch.push(...filenames);
                        }
                        const ext = path.extname(name);
                        const type = ext && ext.replace(/^\./, '');
                        if (type) {
                            if (!assets[type]) {
                                assets[type] = {};
                            }
                            assets[type][path.basename(name, ext)] = value;
                        }
                    });
                }
            })
        ],
        optimization: {
            splitChunks: {
                cacheGroups: {
                    vendor: {
                        test: new RegExp(
                            `[\\\/]node_modules[\\\/](${libs.join('|')})[\\\/]`
                        ),
                        chunks: 'all'
                    }
                }
            }
        }
    };
    if (mode === 'development') {
           config.devtool = 'cheap-source-map';
            await PWADevServer.configure(
                {
                    graphqlPlayground: true,
                    ...projectConfig.sections(
                        'devServer',
                        'imageService',
                        'customOrigin'
                    ),
                    ...projectConfig.section('magento'),
                    upwardPath:path.resolve(__dirname,projectConfig.section('upwardJs').upwardPath)

                },
                config
            );
    } else if (mode === 'production') {
        config.performance = {
            hints: 'warning'
        };
        if (projectConfig.env.DEBUG_BEAUTIFY) {
            config.optimization.minimize = false;
        } else {
            config.optimization.minimizer = [
                new TerserPlugin({
                    parallel: true,
                    cache: true,
                    terserOptions: {
                        ecma: 8,
                        parse: {
                            ecma: 8
                        },
                        compress: {
                            drop_console: true
                        },
                        output: {
                            ecma: 7,
                            semicolons: false
                        },
                        keep_fnames: true
                    }
                })
            ];
        }
    } else {
        throw Error(`Unsupported environment mode in webpack config: ${mode}`);
    }
    return config;
};