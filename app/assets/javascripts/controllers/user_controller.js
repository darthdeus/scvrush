Scvrush.UserController = Em.ObjectController.extend({

  isCurrentUser: function() {
    return this.get("content") === Scvrush.currentUser;
  }.property("content"),

  isFollowingUser: function() {
    return Scvrush.currentUser.isFollowing(this.get("content"));
  }.property("content", "Scvrush.currentUser.following.@each.item"),

  follow: function(event) {
    Scvrush.currentUser.follow(event.context);
  },

  unfollow: function(event) {
    Scvrush.currentUser.unfollow(event.context);
  },

});
