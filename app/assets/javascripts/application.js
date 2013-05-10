//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require ./env
//= require ./vendor/manifest

//= require bootstrap
//= require handlebars
//= require ember
//= require ember-data
//= require ./vendor/ember-easyForm
//= require ./vendor/ember-validations
//= require ./scvrush

window.onerror = function(message) {
  if (confirm("Something went wrong: " + message)) {
    window.location.reload();
  }
};
