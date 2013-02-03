Scvrush.UserIndexController = Ember.Controller.extend({

  needs: ["user"],

  user: function() {
    return this.get("controllers.user.content");
  }.property("controllers.user.content"),

  isCurrentUser: function() {
    return this.get("user") === Scvrush.currentUser;
  }.property("user"),

  isFollowingUser: function() {
    return Scvrush.currentUser.isFollowing(this.get("user"));
  }.property("user.followers.@each.username", "Scvrush.currentUser.following.@each.username"),

  follow: function(user) {
    Scvrush.currentUser.follow(user);
  },

  unfollow: function(user) {
    Scvrush.currentUser.unfollow(user);
  },

  deleteStatus: function(status) {
    status.deleteRecord();
    status.get("transaction").commit();
  },

});

