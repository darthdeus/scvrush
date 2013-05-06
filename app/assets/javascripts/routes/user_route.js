Scvrush.UserRoute = Scvrush.Route.extend({

  events: {
    logout: function() {
      $.ajax({
        url: "/logout",
        method: "DELETE",
        success: function() {
          document.location = "/";
        }
      });
    }
  },

  setupController: function(controller, model) {
    if (model instanceof Scvrush.CurrentUser) {
      controller.set("model", model.get("content"));
    }
  }

})
