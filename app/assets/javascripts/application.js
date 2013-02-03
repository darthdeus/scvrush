//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require ./vendor/manifest

//= require handlebars
//= require ./vendor/ember
//= require ember-data
//= require ./scvrush

Handlebars.registerHelper("debug", function(optionalValue) {
  console.log("Current Context");
  console.log("====================");
  console.log(this);

  if (optionalValue) {
    console.log("Value");
    console.log("====================");
    console.log(optionalValue);
  }
});

window.c = Ember.c = function(name) {
  return Scvrush.__container__.lookup("controller:" + name);
}
