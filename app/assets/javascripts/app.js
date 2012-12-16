Scvrush = Ember.Application.create({
  rootElement: "#ember-app",
  ready: function() {
    var user_id = this.$(this.rootElement).data("user-id");
    Scvrush.currentUser = Scvrush.get("store").find(Scvrush.User, user_id);
  }
});
