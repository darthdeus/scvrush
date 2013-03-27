//= require_self
//= require ./app
//= require ./store
//= require_tree ./models
//= require_tree ./controllers
//= require_tree ./views
//= require_tree ./helpers
//= require_tree ./templates
//= require_tree ./routes

Scvrush = Ember.Application.create({
  LOG_TRANSITIONS: true,
  rootElement: "#ember-app",
  ready: function() {
    var userId = this.$(this.rootElement).data("user-id");
    Scvrush.currentUser = Scvrush.User.find(userId);

    var bindKeys = function(event) {
      Ember.set("Scvrush.keyboard.shiftKey", event.shiftKey);
      Ember.set("Scvrush.keyboard.altKey", event.altKey);
      Ember.set("Scvrush.keyboard.ctrlKey", event.ctrlKey);
    };

    $(document).keydown(bindKeys);
    $(document).keyup(bindKeys);
  }
});

Scvrush.keyboard = Ember.Object.create();

window.c = Ember.c = function(name) {
  return Scvrush.__container__.lookup("controller:" + name);
}
