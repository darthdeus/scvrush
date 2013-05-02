Scvrush.CurrentUser = Ember.ObjectProxy.extend({

  follow: function(user) {
    var url = "/users/" + user.get("id") + "/follow";

    $.post(url, function(data) {
      Ember.run(function() {
        user.get("store").loadMany(Scvrush.User, data.users);
      });
    });
  },

  unfollow: function(user) {
    var url = "/users/" + user.get("id") + "/unfollow";

    $.post(url, { "_method": "DELETE" }, function(data) {
      Ember.run(function() {
        user.get("store").loadMany(Scvrush.User, data.users);
      });
    });
  },

  isFollowing: function(anotherUser) {
    return this.get("followees").contains(anotherUser);
  },

});
