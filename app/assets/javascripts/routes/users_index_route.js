Scvrush.UsersIndexRoute = Scvrush.Route.extend({

  model: function() {
    return Scvrush.User.find();
  }

});
