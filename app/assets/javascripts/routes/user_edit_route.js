Scvrush.UserEditRoute = Scvrush.Route.extend({

  model: function() {
    return this.modelFor("user");
  },

  redirect: function(model) {
    if (model.get("isTrial")) {
      this.transitionTo("user.activate", model);
    }
  },

  activate: function() {
    var user = this.modelFor("user");
        transaction = user.get("store").transaction();

    transaction.add(user);
  },

  deactivate: function() {
    this.modelFor("user").get("transaction").rollback();
  },

});
