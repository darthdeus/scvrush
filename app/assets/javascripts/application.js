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
//= require ./vendor/ember-validations
//= require ./scvrush

$(function() {
  Trackets.init({
    api_key: "fad2a363d5c034a49804f2c64ffe4856",
    api_base_url: "http://trackets.com"
  });

  // var orig = window.onerror;

  // window.onerror = function(a,b,c,d,e,f,g) {
  //   $.pnotify({
  //     title: "Something went wrong",
  //     text: "We've been notified about this, please reload the page. If the error persists, please contact us via our customer supprt or at jakub@scvrush.com"
  //   });

  //   if (orig) orig.apply(arguments);
  // };
});
