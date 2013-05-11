Scvrush.DashboardRoute = Scvrush.Route.extend({

  redirect: function(model) {
    if (model.get("isTrial")) {
      this.transitionTo("user.activate", model);
    }
  },

  model: function() {
    return Scvrush.currentUser;
  }

})
