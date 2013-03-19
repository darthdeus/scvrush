Scvrush.UserIndexController = Ember.ObjectController.extend({

  isCurrentUser: function() {
    return this.get("content") === Scvrush.currentUser;
  }.property("user"),

  deleteStatus: function(status) {
    status.deleteRecord();
    status.get("transaction").commit();
  },

  users: function() {
    return Scvrush.User.filter();
  }.property()

});

