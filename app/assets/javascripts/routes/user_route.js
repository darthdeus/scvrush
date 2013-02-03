Scvrush.UserEditRoute = Ember.Route.extend({

  events: {
    saveProfile: function() {
      var user = this.modelFor("user");
          route = this;

      user.one("didUpdate", function() {
        alert("Your account was activated. Welcome to SCV Rush!");
        route.transitionTo("home");
      });

      user.get("transaction").commit();
    }
  },

  enter: function() {
    var user = this.modelFor("user");
        transaction = user.get("store").transaction();

    transaction.add(user);
  },

  exit: function() {
    this._super();
    this.modelFor("user").get("transaction").rollback();
  },

});
