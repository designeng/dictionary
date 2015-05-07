require.config({
  baseUrl: "/yii/dictionary/client/app/js",
  paths: {},
  packages: [
    {
      name: "underscore",
      main: "lodash",
      location: "../../bower_components/lodash/dist"
    }, {
      name: "jquery",
      main: "jquery",
      location: "../../bower_components/jquery/dist"
    }, {
      name: "text",
      main: "text",
      location: "../../bower_components/text"
    }, {
      name: "react",
      main: "react",
      location: "../../bower_components/react"
    }, {
      name: "reactRouter",
      main: "ReactRouter",
      location: "../../bower_components/react-router/build/umd"
    }
  ],
  shim: {},
  hbs: {
    templateExtension: ".html"
  }
});

require(["components/quiz/app"], function() {});
