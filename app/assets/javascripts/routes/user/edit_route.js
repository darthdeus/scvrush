Scvrush.UserEditRoute = Scvrush.Route.extend({

  model: function() {
    return this.modelFor("user");
  },

  redirect: function(model) {
    if (model.get("isTrial")) {
      this.transitionTo("user.activate", model);
    }
  }

});
