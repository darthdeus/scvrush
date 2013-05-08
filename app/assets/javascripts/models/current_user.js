Scvrush.CurrentUser = Ember.ObjectProxy.extend({

  content: null,

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
    var array = this.get("followees");
    return array && array.contains(anotherUser);
  },

  changeUser: function(user) {
    this.set("content", user);

    if (user) {
      CS.unsubscribe("user-" + this.get("username"));
      CS.subscribe("user-" + user.get("username"), this._loadStuff);
    }
  },

  _loadStuff: function(data) {
  }

});
