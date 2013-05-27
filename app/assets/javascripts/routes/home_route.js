Scvrush.HomeRoute = Scvrush.Route.extend({

  model: function() {
    return Scvrush.currentUser;
  },

  activate: function() {
    this.modelFor("home").get("content").addObserver("isTrial", this, "_gotoDashboard");
  },

  deactivate: function() {
    this.modelFor("home").get("content").removeObserver("isTrial", this, "_gotoDashboard");
  },

  _gotoDashboard: function() {
    if (this.modelFor("home").get("isTrial") === false) {
      Ember.run.next(this, function() {
        this.transitionTo("dashboard");
      });
    }
  }

});
