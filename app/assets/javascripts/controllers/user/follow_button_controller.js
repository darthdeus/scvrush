Scvrush.UserFollowButtonController = Ember.ObjectController.extend({

  isFollowingUser: function() {
    return Scvrush.currentUser.isFollowing(this.get("content"));
  }.property("followers.@each.username", "Scvrush.currentUser.following.@each.username"),

  follow: function(user) {
    Scvrush.currentUser.follow(user);
  },

  unfollow: function(user) {
    Scvrush.currentUser.unfollow(user);
  },

});
