//= require_self
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
    var user = Scvrush.User.find(userId);

    user.set("stateManager.enableLogging", true);

    Scvrush.currentUser = Scvrush.CurrentUser.create();
    Scvrush.currentUser.changeUser(user);
  }
});

Scvrush.keyboard = Ember.Object.create();

window.c = Ember.c = function(name) {
  return Scvrush.__container__.lookup("controller:" + name);
}
