#!/bin/bash

echo -e
echo -e
tput sgr0
echo -ne '\E[30;42m'
echo -e "\033[1mSetup For Pwa Magento:\033[0m"
echo -en '\E[5m'

echo -e
echo -e

tput sgr0
echo -e "Enter Company Name (Example - adobe)   - \c"
read companyName
echo -e "Enter Template Name (Example - watchtime-concept) - \c"
read templateName
echo -e "Enter Alias Name (Example - watchtime) - \c"
read scriptName
echo -e "Enter Author Name - \c"
read authorName
echo -e "Enter Version Number (Example - 1.0.0) - \c"
read versionNumber
echo -e "Enter Template Description - \c"
read templateDescription

echo -e "\e[1;32m"
echo "#########################"
echo "# Step 1: Creating package.json #"
echo "#########################"
echo -e "\e[00m"



cat > package.json << EOF
{
  "name": "$templateName-fallback",
  "version": "$versionNumber",
  "private": true,
  "workspaces": [
    "src/pwa-studio/packages/babel-preset-peregrine",
    "src/pwa-studio/packages/graphql-cli-validate-magento-pwa-queries",
    "src/pwa-studio/packages/peregrine",
    "src/pwa-studio/packages/pwa-buildpack",
    "src/pwa-studio/packages/venia-concept",
    "src/pwa-studio/packages/upward-js",
    "src/pwa-studio/packages/upward-spec",
    "src/$companyName/$templateName"
  ],
  "author": "$authorName",
  "license": "SEE LICENSE IN LICENSE.txt",
  "homepage": "https://github.com/magento/pwa-studio",
  "bugs": {
    "url": "https://github.com/magento/pwa-studio/issues"
  },
  "scripts": {
    "build-venia": "yarn venia run build",
	"build:venia-dev": "yarn venia run build:dev",
    "build-$scriptName": "yarn $scriptName run build",
	"build:$scriptName-dev": "yarn $scriptName run build:dev",
    "clean:all": "yarn workspaces run -s clean && rimraf ./node_modules && rm -rf src/ *.js *.json *.lock",
    "clone:pwa-studio": "mkdir -p src && cd src && git clone https://github.com/magento-research/pwa-studio.git",
    "clean:dist": "yarn workspaces run clean",
    "coveralls": "cat ./coverage/lcov.info | coveralls",
    "danger": "danger-ci",
    "lint-venia": "eslint '@(src/pwa-studio/packages|scripts)/**/{*.js,package.json}' --ignore-pattern node_modules --ignore-pattern storybook-dist",
    "lint-$scriptName": "eslint '@(src|scripts)/**/{*.js,package.json}' --ignore-pattern node_modules --ignore-pattern storybook-dist --ignore-pattern dist",
    "postbuild-venia": "rimraf \"./src/pwa-studio/packages/*/dist/{,**/}__*__\"",
    "postbuild-watchtime":  "rimraf \"./src/$companyName/$templateName/dist/*\"",
    "prettier-venia": "prettier --write '@(src|packages|scripts)/**/*.@(js|css)' '*.js'",
    "prettier:validate-venia": "prettier-check '@(src|packages|scripts)/**/*.@(js|css)' '*.js'",
    "prettier:check-venia": "prettier --list-different '@(src|packages|scripts)/**/*.@(js|css)' '*.js'",
    "prettier-$scriptName": "prettier --write 'src/$companyName/**/*.@(js|css)' '*.js'",
    "prettier:validate-$scriptName": "prettier-check 'src/$companyName/**/*.@(js|css)' '*.js'",
    "prettier:check-$scriptName": "prettier --list-different 'src/$companyName/**/*.@(js|css)' '*.js'",
    "stage:venia": "yarn venia run start",
    "stage:$scriptName": "yarn $scriptName run start",
    "stats:venia": "yarn venia run build:analyze && yarn venia run stats",
    "stats:$scriptName": "yarn $scriptName run build:analyze && yarn $scriptName run stats",
    "storybook:venia": "yarn venia run storybook",
    "test": "jest",
    "test:ci": "jest --no-cache -i --json --outputFile=test-results.json",
    "test:debug": "node --inspect-brk node_modules/.bin/jest -i --no-cache",
    "test:dev": "jest --watch",
    "validate-queries": "yarn venia run validate-queries",
    "validate-queries-$scriptName": "yarn $scriptName run validate-queries",
    "watch:all-venia": "node src/pwa-studio/scripts/watch-all.js",
	"venia": "yarn workspace @magento/venia-concept",
	"$scriptName": "yarn workspace @adobe/watchtime-concept",
    "watch:venia": "yarn workspace @$companyName/$templateName run watch",
    "watch:$scriptName": "yarn $scriptName run watch"
},
  "devDependencies": {
    "@magento/eslint-config": "~1.4.1",
    "chalk": "~2.4.2",
    "chokidar": "~2.1.2",
    "coveralls": "~3.0.3",
    "danger": "^7.1.4",
    "eslint": "~5.14.1",
    "eslint-plugin-babel": "~5.3.0",
    "eslint-plugin-graphql": "~3.0.3",
    "eslint-plugin-jsx-a11y": "~6.2.1",
    "eslint-plugin-node": "~8.0.1",
    "eslint-plugin-package-json": "~0.1.3",
    "eslint-plugin-react": "~7.12.4",
    "eslint-plugin-react-hooks": "~1.6.0",
    "execa": "~1.0.0",
    "figures": "~2.0.0",
    "first-run": "~2.0.0",
    "graphql-tag": "~2.10.1",
    "husky": "~1.3.1",
    "identity-obj-proxy": "~3.0.0",
    "jest": "~24.3.1",
    "jest-fetch-mock": "~2.1.1",
    "jest-junit": "~6.3.0",
    "jest-transform-graphql": "~2.1.0",
    "lerna": "~3.13.0",
    "lodash.debounce": "~4.0.8",
    "prettier": "~1.16.4",
    "prettier-check": "~2.0.0",
    "rimraf": "~2.6.3"
  },
  "optionalDependencies": {
    "bundlesize": "~0.17.1",
    "sharp": "~0.22.1"
  },
  "resolutions": {
        "graphql": "14.4.2"
  },
  "engines": {
    "node": "10.x",
    "yarn": ">=1.12.0"
  },
  "husky": {
    "hooks": {
      "pre-push": "yarn run prettier:validate && yarn run lint"
    }
  },
  "bundlesize": [
    {
      "path": "./src/pwa-studio/packages/venia-concept/dist/js/{client,vendor}.js",
      "maxSize": "250 kB"
    },
    {
      "path": "./src/pwa-studio/packages/venia-concept/dist/js/[0-9]-*.js",
      "maxSize": "100 kB"
    }
  ]
}
EOF

echo -e "\e[1;32m"
echo "#########################"
echo "# Step 2: Creating .eslintignore #"
echo "#########################"
echo -e "\e[00m"

rm -rf "/tmp/.eslintignore"
wget -P /tmp/ https://raw.githubusercontent.com/magento-research/pwa-studio/develop/.eslintignore
cp -RP "/tmp/.eslintignore" .

echo -e "\e[1;32m"
echo "#########################"
echo "# Step 3: Creating lerna.json #"
echo "#########################"
echo -e "\e[00m"

cat > lerna.json << EOF
{
    "version": "independent",
    "packages": [
        "src/pwa-studio/packages/*",
        "src/$companyName/$templateName"

    ],
    "npmClient": "yarn",
    "useWorkspaces": true
}
EOF

echo -e "\e[1;32m"
echo "############################################################################################################################################################"
echo "# Step 4: Creating eslintrc.js,.nowignore,.prettierignore,.editorconfig,.gitignore #, prettier.config.js,magento-compatibility.js,jest,babel,yarnrc,npmrc"
echo "############################################################################################################################################################"
echo -e "\e[00m"


rm -rf "/tmp/.eslintrc.js"
wget -P /tmp/ https://raw.githubusercontent.com/magento-research/pwa-studio/develop/.eslintrc.js
cp -RP "/tmp/.eslintrc.js" .


rm -rf "/tmp/.nowignore"
wget -P /tmp/ https://raw.githubusercontent.com/magento-research/pwa-studio/develop/.nowignore
cp -RP "/tmp/.nowignore" .


rm -rf "/tmp/.prettierignore"
wget -P /tmp/ https://raw.githubusercontent.com/magento-research/pwa-studio/develop/.prettierignore
cp -RP "/tmp/.prettierignore" .



rm -rf "/tmp/.editorconfig"
wget -P /tmp/ https://raw.githubusercontent.com/magento-research/pwa-studio/develop/.editorconfig
cp -RP "/tmp/.editorconfig" .


rm -rf "/tmp/.gitignore"
wget -P /tmp/ https://raw.githubusercontent.com/magento-research/pwa-studio/develop/.gitignore
cp -RP "/tmp/.gitignore" .


rm -rf "/tmp/prettier.config.js"
wget -P /tmp/ https://raw.githubusercontent.com/magento-research/pwa-studio/develop/prettier.config.js
cp -RP "/tmp/prettier.config.js" .

rm -rf "/tmp/now.json"
wget -P /tmp/ https://raw.githubusercontent.com/magento-research/pwa-studio/develop/now.json
cp -RP "/tmp/now.json" .


rm -rf "/tmp/magento-compatibility.js"
wget -P /tmp/ https://raw.githubusercontent.com/magento-research/pwa-studio/develop/magento-compatibility.js
cp -RP "/tmp/magento-compatibility.js" .


rm -rf "/tmp/jest.config.js"
wget -P /tmp/ https://raw.githubusercontent.com/magento-research/pwa-studio/develop/jest.config.js
cp -RP "/tmp/jest.config.js" .


rm -rf "/tmp/babel.config.js"
wget -P /tmp/ https://raw.githubusercontent.com/magento-research/pwa-studio/develop/babel.config.js
cp -RP "/tmp/babel.config.js" .


rm -rf "/tmp/.yarnrc"
wget -P /tmp/ https://raw.githubusercontent.com/magento-research/pwa-studio/develop/.yarnrc
cp -RP "/tmp/.yarnrc" .


rm -rf "/tmp/.npmrc"
wget -P /tmp/ https://raw.githubusercontent.com/magento-research/pwa-studio/develop/.npmrc
cp -RP "/tmp/.npmrc" .


echo -e
echo -e

echo -e "\e[1;32m"
echo "#########################"
echo "# Step 5: Creating Source Directory #"
echo "#########################"
echo -e "\e[00m"


mkdir -p src

cd src

echo -e
echo -e


echo -e "\e[1;32m"
echo "#########################"
echo "# Step 6: Cloning Pwa studio #"
echo "#########################"
echo -e "\e[00m"




git clone https://github.com/magento-research/pwa-studio.git

echo -e
echo -e

echo -e "\e[1;32m"
echo "#########################"
echo "# Step 7: Creating Company Name and Template #"
echo "#########################"
echo -e "\e[00m"


mkdir -p $companyName

cd $companyName

mkdir -p $templateName

cd $templateName

cat > package.json << EOF
{
  "name": "@$companyName/$templateName",
  "version": "$versionNumber",
  "publishConfig": {
    "access": "public"
  },
  "description": "$templateDescription",
  "main": "src/index.js",
  "browser": {
    "@magento/venia-drivers": "../../pwa-studio/packages/venia-concept/src/drivers"
  },
  "scripts": {
    "build": "yarn run clean && node ../../pwa-studio/packages/pwa-buildpack/bin/buildpack load-env --core-dev-mode . yarn run validate-queries && yarn run build:prod",
    "build:analyze": "yarn run clean && mkdir dist && webpack -p --profile --no-progress --env.mode production --json > dist/build-stats.json && webpack-bundle-analyzer dist/build-stats.json",
    "build:dev": " ",
    "build:prod": "webpack -p --color --no-progress --profile --env.mode production",
    "clean": "rimraf dist",
    "download-schema": "graphql get-schema --project $scriptName --insecure",
    "now-build": "../../now-build.sh",
    "prepublishOnly": "yarn run build",
    "start": "node server.js",
    "start:debug": "node --inspect-brk ./node_modules/.bin/webpack-dev-server --progress --color --env.mode development",
    "stats": "webpack-bundle-analyzer dist/build-stats.json",
    "storybook": "start-storybook -p 9001 -c .storybook",
    "storybook:build": "build-storybook -c .storybook -o storybook-dist",
    "validate-queries": "yarn run download-schema && graphql validate-magento-pwa-queries --project $scriptName",
    "watch": "webpack-dev-server --progress --color --env.mode development"
  },
  "repository": "github:magento-research/pwa-studio",
  "author": "Magento Commerce",
  "license": "(OSL-3.0 OR AFL-3.0)",
  "bugs": {
    "url": "https://github.com/magento-research/pwa-studio/issues"
  },
  "homepage": "https://github.com/magento-research/pwa-studio/tree/master/packages/venia-concept#readme",
  "dependencies": {
    "@babel/runtime": "~7.4.2",
    "@magento/peregrine": "~3.0.0",
    "apollo-boost": "~0.1.28",
    "apollo-cache-inmemory": "~1.4.3",
    "apollo-cache-persist": "~0.1.1",
    "apollo-client": "~2.4.13",
    "apollo-link-context": "~1.0.14",
    "apollo-link-http": "~1.5.11",
    "braintree-web-drop-in": "~1.16.0",
    "graphql-cli": "~3.0.11",
    "graphql-cli-validate-magento-pwa-queries": "~1.0.0",
    "graphql-tag": "~2.10.1",
    "informed": "~2.1.13",
    "lodash.over": "~4.7.0",
    "memoize-one": "~5.0.0",
    "prop-types": "~15.7.2",
    "react": "~16.8.3",
    "react-apollo": "~2.5.5",
    "react-dom": "~16.8.3",
    "react-feather": "~2.0.3",
    "react-redux": "~6.0.1",
    "react-router-dom": "~5.0.0",
    "redux": "~4.0.1",
    "redux-actions": "~2.6.4",
    "redux-thunk": "~2.3.0",
    "uuid": "~3.3.2"
  },
  "devDependencies": {
    "@babel/core": "~7.3.4",
    "@babel/plugin-proposal-class-properties": "~7.3.4",
    "@babel/plugin-proposal-object-rest-spread": "~7.3.4",
    "@babel/plugin-syntax-dynamic-import": "~7.2.0",
    "@babel/plugin-syntax-jsx": "~7.2.0",
    "@babel/plugin-transform-react-jsx": "~7.3.0",
    "@babel/plugin-transform-runtime": "~7.4.4",
    "@babel/preset-env": "~7.3.4",
    "@magento/pwa-buildpack": "~3.0.0",
    "@magento/upward-js": "~2.2.0",
    "@storybook/react": "~4.1.13",
    "babel-core": "~7.0.0-bridge.0",
    "babel-jest": "~24.1.0",
    "babel-loader": "~8.0.5",
    "babel-plugin-dynamic-import-node": "~2.2.0",
    "babel-plugin-graphql-tag": "~2.0.0",
    "chalk": "~2.4.2",
    "css-loader": "~2.1.1",
    "dotenv": "~6.2.0",
    "enzyme": "~3.9.0",
    "enzyme-adapter-react-16": "~1.9.1",
    "identity-obj-proxy": "~3.0.0",
    "node-fetch": "~2.3.0",
    "react-test-renderer": "~16.8.6",
    "rimraf": "~2.6.3",
    "terser-webpack-plugin": "~1.2.3",
    "webpack": "~4.29.5",
    "webpack-assets-manifest": "~3.1.1",
    "webpack-bundle-analyzer": "~3.3.2",
    "webpack-cli": "~3.2.3",
    "webpack-dev-server": "~3.2.1"
  },
  "optionalDependencies": {
    "sharp": "~0.21.2"
  },
  "engines": {
    "node": "10.x",
    "yarn": ">=1.12.0"
  },
  "module": "src/index.js",
  "es2015": "src/index.js",
  "esnext": "src/index.js",
  "sideEffects": [
    "./src/index.js",
    "./src/**/*.css"
  ]
}
EOF

rm -rf "/tmp/.eslintignore"
wget -P /tmp/ https://raw.githubusercontent.com/magento-research/pwa-studio/develop/packages/venia-concept/.eslintignore
cp -RP "/tmp/.eslintignore" .


rm -rf "/tmp/.eslintrc.js"
wget -P /tmp/ https://raw.githubusercontent.com/magento-research/pwa-studio/develop/packages/venia-concept/.eslintrc.js
cp -RP "/tmp/.eslintrc.js" .


rm -rf "/tmp/.gitignore"
wget -P /tmp/ https://raw.githubusercontent.com/magento-research/pwa-studio/develop/packages/venia-concept/.gitignore
cp -RP "/tmp/.gitignore" .


cat > graphqlconfig.json << EOF
{
    "projects": {
        "$scriptName": {
            "schemaPath": "lastCachedGraphQLSchema.json",
            "extensions": {
                "endpoints": {
                    "default": "${env:MAGENTO_BACKEND_URL}/graphql"
                },
                "validate-magento-pwa-queries": {
                    "clients": ["apollo", "literal"],
                    "filesGlob": "src/**/*.{js,graphql,gql}"
                }
            }
        }
    }
}
EOF

mv graphqlconfig.json .graphqlconfig


rm -rf "/tmp/.npmignore"
wget -P /tmp/ https://raw.githubusercontent.com/magento-research/pwa-studio/develop/packages/venia-concept/.npmignore
cp -RP "/tmp/.npmignore" .


rm -rf "/tmp/server-lambda.js"
wget -P /tmp/ https://raw.githubusercontent.com/magento-research/pwa-studio/develop/packages/venia-concept/server-lambda.js
cp -RP "/tmp/server-lambda.js" .


rm -rf "/tmp/server.js"
wget -P /tmp/ https://raw.githubusercontent.com/magento-research/pwa-studio/develop/packages/venia-concept/server.js
cp -RP "/tmp/server.js" .


rm -rf "/tmp/upward.yml"
wget -P /tmp/ https://raw.githubusercontent.com/magento-research/pwa-studio/develop/packages/venia-concept/upward.yml
cp -RP "/tmp/upward.yml" .

echo -e "\e[1;32m"
echo "#########################"
echo "# Step 8: Creating webpack.config.js inside ur theme #"
echo "#########################"
echo -e "\e[00m"


cat > webpack.config.js << "EOF"
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
                    upwardPath: projectConfig.section('upwardJs').upwardPath
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
EOF




mkdir -p src

cd src

cp -R ../../../pwa-studio/packages/venia-concept/src/queries .

cd ..

cp -R ../../pwa-studio/packages/venia-concept/templates .

git clone https://github.com/arjunadobe/pwastudio.git

cp -rf pwastudio/media/ .

cp -rf pwastudio/static/ .

cp -rf pwastudio/src/* src/

rm -rf pwastudio

cd ../../../

echo -e "\e[1;32m"
echo "#########################"
echo "# Installing yarn into your package #"
echo "#########################"
echo -e "\e[00m"
echo -e
echo -e
yarn install

echo -e "\e[1;32m"
echo "#########################"
echo "# Now Building venia theme #"
echo "#########################"
echo -e "\e[00m"
echo -e
echo -e

yarn build-venia
echo -e
echo -e


echo -e "\e[1;32m"
echo "#########################"
echo "# Now Adding sample modules to our custom theme #"
echo "#########################"

cd src/$companyName/$templateName
yarn add nuka-carousel
cd ../../../

echo -e "\e[1;32m"
echo "#########################"
echo "# Now Building your custom theme #"
echo "#########################"
echo -e "\e[00m"
echo -e
echo -e

yarn build-$scriptName

echo -e "\e[1;32m"
echo "#########################"
echo "# Now Creating Custom Origin For your current theme #"
echo "#########################"
yarn buildpack create-custom-origin src/$companyName/$templateName


echo -e "\e[1;32m"
echo "#########################"
echo "# Now Running your current theme #"
echo "#########################"
echo -e "\e[00m"
echo -e
echo -e
yarn watch:$scriptName