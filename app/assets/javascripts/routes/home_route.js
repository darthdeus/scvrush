Scvrush.HomeRoute = Scvrush.Route.extend({

  model: function() {
    return Scvrush.currentUser;
  },

  redirect: function(user) {
    if (!user.get("isTrial")) {
      this.transitionTo("dashboard");
    }
  }

});
