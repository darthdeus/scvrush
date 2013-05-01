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
  }

})
