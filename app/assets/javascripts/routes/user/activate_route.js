Scvrush.UserActivateRoute = Scvrush.Route.extend({

  model: function() {
    return Scvrush.currentUser;
  },

  deactivate: function() {
    this.modelFor("user").get("transaction").rollback();
  }

});
