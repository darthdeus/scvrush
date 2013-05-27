Scvrush.UserRoute = Scvrush.Route.extend({

  setupController: function(controller, model) {
    if (model instanceof Scvrush.CurrentUser) {
      controller.set("model", model.get("content"));
    } else {
      controller.set("model", model);
    }
  }

})
