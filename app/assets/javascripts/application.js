//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require ./vendor/manifest
//= require ./bracket

//= require_self
//= require bootstrap
//= require handlebars
//= require ember
//= require ember-data
//= require ./scvrush

ENV = {};
ENV.EXPERIMENTAL_CONTROL_HELPER = true;

// Handlebars.registerHelper("debug", function(optionalValue) {
//   console.log("Current Context");
//   console.log("====================");
//   console.log(this);
// 
//   if (optionalValue) {
//     console.log("Value");
//     console.log("====================");
//     console.log(optionalValue);
//   }
// });
// 
// window.c = Ember.c = function(name) {
//   return Scvrush.__container__.lookup("controller:" + name);
// }
