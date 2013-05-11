//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require ./env
//= require ./vendor/manifest
//= require pnotify

//= require bootstrap
//= require handlebars
//= require ember
//= require ember-data
//= require ./vendor/ember-easyForm
//= require ./vendor/ember-validations
//= require ./scvrush

window.onerror = function(message) {
  $.pnotify({
    title: "Something went wrong",
    text: "We've been notified about this, please reload the page. If the error persists, please contact us via our customer supprt or at jakub@scvrush.com"
  });
};
