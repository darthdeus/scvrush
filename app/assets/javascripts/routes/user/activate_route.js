Scvrush.UserActivateRoute = Scvrush.Route.extend({

  model: function() {
    return this.modelFor("user");
  },

  activate: function() {
    var user = this.modelFor("user");
        transaction = user.get("store").transaction();

    transaction.add(user);
  },

  deactivate: function() {
    this.modelFor("user").get("transaction").rollback();
  }

});
