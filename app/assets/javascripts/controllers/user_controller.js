Scvrush.UserController = Em.ObjectController.extend({

  isCurrentUser: function() {
    return this.get("content") === Scvrush.currentUser;
  }.property("content"),

  isFollowing: function() {
    return Scvrush.currentUser.isFollowing(this.get("content"));
  }.property("content"),

  follow: function(event) {
    Scvrush.currentUser.follow(event.context);
  },

});
