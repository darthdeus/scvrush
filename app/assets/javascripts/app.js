Scvrush = Ember.Application.create({
  LOG_TRANSITIONS: true,
  rootElement: "#ember-app",
  ready: function() {
    var userId = this.$(this.rootElement).data("user-id");
    Scvrush.currentUser = Scvrush.User.find(userId);
  }
});

Scvrush.Models = Ember.Namespace.extend({
});
