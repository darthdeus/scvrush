//= require_self
//= require ./store
//= require_tree ./mixins
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

    Scvrush.currentUser = Scvrush.CurrentUser.create();
    Scvrush.currentUser.changeUser(user);
  }

});

Scvrush.keyboard = Ember.Object.create();


// Debugging
window.a = function(property) {
  var model = d().get("model");

  if (property) {
    return model.get(property);
  } else {
    return model;
  }
};

window.d = function(property) {
  var path = c("application").get("currentPath");

  var controller = c(path.split(".").slice(-1).join(".")) ||
                   c(path.split(".").slice(-2).join("."));

  if (property) {
    return controller.get(property);
  } else {
    return controller
  }
};

window.c = function(name) {
  return Scvrush.__container__.lookup("controller:" + name);
};
