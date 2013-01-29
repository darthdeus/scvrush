Scvrush.UserController = Ember.ObjectController.extend({

  isCurrentUser: function() {
    return this.get("content") === Scvrush.currentUser;
  }.property("content"),

  isFollowingUser: function() {
    return Scvrush.currentUser.isFollowing(this.get("content"));
  }.property("content.followers.@each.username", "Scvrush.currentUser.following.@each.username"),

  follow: function(user) {
    Scvrush.currentUser.follow(user);
  },

  unfollow: function(user) {
    Scvrush.currentUser.unfollow(user);
  },

});
