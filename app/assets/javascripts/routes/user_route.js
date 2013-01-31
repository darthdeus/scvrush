Scvrush.UserIndexRoute = Ember.Route.extend({
  // setupController: function(controller, model) {
  //   controller.set("content", controller.get("controllers.users"));
  // },
});

Scvrush.UserEditRoute = Ember.Route.extend({

  setupController: function(controller, model) {
    var user = this.controllerFor("user").get("content");
  },

  events: {

    saveProfile: function() {
      var user = this.controllerFor("user").get("content"),
          route = this;

      user.one("didUpdate", function() {
        alert("Your account was activated. Welcome to SCV Rush!");
        route.transitionTo("home");
      });

      user.get("store").commit();
    }

  }


});
