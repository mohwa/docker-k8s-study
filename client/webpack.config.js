'use strict';
const path = require('path');
const webpack = require('webpack');
const HtmlWebPackPlugin = require('html-webpack-plugin');
// const CopyWebpackPlugin = require('copy-webpack-plugin');
const HtmlWebpackInjector = require('html-webpack-injector');

const rootPath = path.resolve('.');
const outputPath = path.resolve('./dist');

module.exports = () => {
    return {
        context: rootPath,
        mode: 'development',
        target: 'web',
        entry: {
            'app': path.resolve('src/index.js'),
        },
        output: {
            path: outputPath,
            publicPath: '/',
            // filename: getOutputFileName(),
            // chunkFilename: getOutputFileName('chunk'),
        },
        devtool: 'source-map',
        resolve: {
            modules: ['src', 'node_modules'],
            extensions: ['.js', '.jsx', '.json', 'css'],
            // alias: {
            //     '@common': utils.resolve('src/common'),
            //     '@store': utils.resolve('src/store'),
            //     '@components': utils.resolve('src/components'),
            //     '@components-common': utils.resolve('src/components-common'),
            //     '@config': utils.resolve('src/config'),
            //     '@constants': utils.resolve('src/constants'),
            //     '@interfaces': utils.resolve('src/interfaces'),
            //     '@utils': utils.resolve('src/utils'),
            //     '@error': utils.resolve('src/error'),
            //     '@markup': utils.resolve('public/static'),
            //     '@languages': utils.resolve('src/languages'),
            //     '@hooks': utils.resolve('src/hooks'),
            //     '@assets': utils.resolve('src/assets'),
            //     '@lib': utils.resolve('src/lib'),
            //     // for tests
            //     '@tests': utils.resolve('tests'),
            //     '@mock': utils.resolve('tests/__mock__'),
            //     '@story-utils': utils.resolve('.storybook/utils'),
            //     '@cypress-helpers': utils.resolve('cypress/helpers'),
            // },
        },
        module: {
            rules: [
                {
                    test: /\.(js|jsx)$/,
                    use: ['babel-loader'],
                    include: [path.resolve('src')],
                    exclude: /node_modules/,
                },
            ],
        },
        plugins: [
            new webpack.ProgressPlugin(),
            new HtmlWebPackPlugin({
                template: 'src/index.html',
                filename: 'index.html',
            }),
            new HtmlWebpackInjector(),
            new webpack.DefinePlugin({}),
            // new CopyWebpackPlugin([
            //     {
            //         from: utils.resolve('public/**/*'),
            //         to: outputPath,
            //         context: 'public',
            //     },
            // ]),
        ],
        optimization: {
            runtimeChunk: {
                name: 'runtime',
            },
            splitChunks: {
                minSize: 30000,
                maxSize: 1010000,
                minChunks: 1,
                cacheGroups: {
                    vendor: {
                        test: /[\\/]node_modules[\\/](react|react-dom|core-js)[\\/]/,
                        name: 'vendor',
                        chunks: 'all',
                    },
                    defaultVendors: {
                        reuseExistingChunk: true,
                    },
                },
            },
            minimize: false,
        },
        devServer: {
            hot: true,
            port: 3000,
            historyApiFallback: {
                index: '/index.html',
            },
        },
    };
};
