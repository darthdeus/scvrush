Scvrush.UsersIndexRoute = Ember.Route.extend({
  model: function() {
    return Scvrush.User.find();
  }
});
