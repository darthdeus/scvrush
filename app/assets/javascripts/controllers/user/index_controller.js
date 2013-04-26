Scvrush.UserIndexController = Ember.ObjectController.extend({

  isCurrentUser: function() {
    return this.get("content") === Scvrush.currentUser;
  }.property("user"),

  deleteStatus: function(status) {
    if (confirm("Are you sure?")) {
      status.deleteRecord();
      status.get("transaction").commit();
    }
  },

  users: function() {
    return Scvrush.User.filter();
  }.property()

});

