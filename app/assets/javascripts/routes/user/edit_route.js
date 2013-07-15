Scvrush.UserEditRoute = Scvrush.Route.extend({

  model: function() {
    return this.modelFor("user");
  },

  setupController: function(controller, model) {
    if (model instanceof Scvrush.CurrentUser) {
      controller.set("model", model.get("content"));
    } else {
      controller.set("model", model);
    }
  },

  redirect: function(model) {
    if (model.get("isTrial")) {
      this.transitionTo("user.activate", model);
    }
  }

});
