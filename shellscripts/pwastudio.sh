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

rm -rf "/tmp/package.json"
wget -P /tmp/ https://raw.githubusercontent.com/arjunadobe/Pwatemplate/master/shellScript/workspace/package.json
cp -RP "/tmp/package.json" .
sed -i -e "s|\TEMPLATENAME|$templateName|" package.json
sed -i -e "s|\VERSIONNUMBER|$versionNumber|" package.json
sed -i -e "s|\TEMPLATESCRIPTNAME|$scriptName|" package.json
sed -i -e "s|\COMPANYNAME|$companyName|" package.json
sed -i -e "s|\YARNTEMPLATESCRIPTNAME|$scriptName|" package.json


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


echo -e "\e[1;32m"
echo "#########################"
echo "# src directory was created #"
echo "#########################"
echo -e "\e[00m"

echo -e
echo -e


echo -e "\e[1;32m"
echo "#########################"
echo "# Step 6: Cloning Pwa studio into the src directory #"
echo "#########################"
echo -e "\e[00m"




git clone https://github.com/magento-research/pwa-studio.git

echo -e
echo -e

echo -e "\e[1;32m"
echo "#########################"
echo "# Step 7: Creating Company Name and Template into src directory #"
echo "#########################"
echo -e "\e[00m"


mkdir -p $companyName

cd $companyName

mkdir -p $templateName

cd $templateName


echo -e "\e[1;32m"
echo "#########################"
echo "# Step 7.1: Now cloning the sample templates from repository #"
echo "#########################"
echo -e "\e[00m"


git clone https://github.com/arjunadobe/Pwatemplate.git

cp -rf Pwatemplate/* .

rm -rf .graphqlconfig

rm -rf package.json

rm -rf Pwatemplate


echo -e "\e[1;32m"
echo "#########################"
echo "# Step 7.2 Creating package.json for your custom template #"
echo "#########################"
echo -e "\e[00m"

rm -rf "/tmp/package.json"
wget -P /tmp/ https://raw.githubusercontent.com/arjunadobe/Pwatemplate/master/shellScript/template/package.json
cp -RP "/tmp/package.json" .
sed -i -e "s|\TEMPLATENAME|@$companyName/$templateName|" package.json
sed -i -e "s|\VERSIONNUMBER|$versionNumber|" package.json
sed -i -e "s|\TEMPLATEDESCRIPTION|$templateDescription|" package.json
sed -i -e "s|\SCRIPTNAMES|$scriptName|" package.json

echo -e "\e[1;32m"
echo "#########################"
echo "# Step 7.3: Creating .graphqlconfig for your custom theme #"
echo "#########################"
echo -e "\e[00m"
rm -rf "/tmp/graphqlconfig.json"
wget -P /tmp/ https://raw.githubusercontent.com/arjunadobe/Pwatemplate/master/shellScript/template/graphqlconfig.json
cp -RP "/tmp/graphqlconfig.json" .

sed -i -e "s|\SCHEMANAME|$scriptName|" graphqlconfig.json

mv graphqlconfig.json .graphqlconfig

echo -e "\e[1;32m"
echo "#########################"
echo "# Step 8: Creating webpack.config.js inside ur theme #"
echo "#########################"
echo -e "\e[00m"

rm -rf "/tmp/webpack.config.js"
wget -P /tmp/ https://raw.githubusercontent.com/arjunadobe/Pwatemplate/master/webpack.config.js
cp -RP "/tmp/webpack.config.js" .

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