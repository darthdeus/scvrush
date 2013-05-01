Scvrush.UserController = Ember.ObjectController.extend({

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

