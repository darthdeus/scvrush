Scvrush.UserIndexController = Ember.Controller.extend({

  needs: ["user"],

  user: function() {
    return this.get("controllers.user.content");
  }.property("controllers.user.content"),

  isCurrentUser: function() {
    return this.get("user") === Scvrush.currentUser;
  }.property("user"),

  deleteStatus: function(status) {
    status.deleteRecord();
    status.get("transaction").commit();
  },

  users: function() {
    return Scvrush.User.filter();
  }.property()

});

