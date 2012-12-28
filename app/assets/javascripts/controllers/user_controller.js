Scvrush.UserController = Em.ObjectController.extend({

  isCurrentUser: function() {
    return this.get("content") === Scvrush.currentUser;
  }.property("content")

});
