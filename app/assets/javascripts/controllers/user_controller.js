Scvrush.UserController = Ember.ObjectController.extend({

  users: function() {
    return Scvrush.User.filter();
  }.property()

});

