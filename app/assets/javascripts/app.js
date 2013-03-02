Scvrush = Ember.Application.create({
  LOG_TRANSITIONS: true,
  rootElement: "#ember-app",
  ready: function() {
    var userId = this.$(this.rootElement).data("user-id");
    Scvrush.currentUser = Scvrush.User.find(userId);
  }
});

window.c = Ember.c = function(name) {
  return Scvrush.__container__.lookup("controller:" + name);
}
