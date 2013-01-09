Scvrush.Models.User = DS.Model.extend({
  username:  DS.attr("string"),
  race:      DS.attr("string"),
  image:     DS.attr("string"),
  bnetInfo:  DS.attr("string"),

  statuses:   DS.hasMany("Scvrush.Models.Status"),
  followers:  DS.hasMany("Scvrush.Models.User"),
  following: DS.hasMany("Scvrush.Models.User"),

  hasFollowers: function() {
    if (this.get("followers")) {
      return this.get("followers.length") > 0;
    }
  },

  raceClass: function() {
    if (this.get("race")) {
      return "race-" + this.get("race").toLowerCase();
    }
  }.property("race"),

  timelineStatuses: function() {
    return this.get("statuses").toArray().reverse();
  }.property("statuses.@each.item"),

  recentStatuses: function() {
    return this.get("statuses").toArray().reverse().slice(0, 5);
  }.property("statuses.@each.item"),

  follow: function(user) {
    var url = "/users/" + user.get("id") + "/follow";

    $.post(url, function(data) {
      Scvrush.store.loadMany(Scvrush.User, data.users);
    });
  },

  unfollow: function(user) {
    var url = "/users/" + user.get("id") + "/unfollow";

    $.post(url, { "_method": "DELETE" }, function(data) {
      Scvrush.store.loadMany(Scvrush.Models.User, data.users);
    });
  },

  isFollowing: function(anotherUser) {
    return this.get("following").contains(anotherUser.get("id"));
  },

});


Scvrush.Models.User.reopenClass({

  findByUsername: function(username) {
    var filtered = Scvrush.store.filter(Scvrush.Models.User, function(user) {
      return user.username == username;
    });

    if (filtered.get("length") > 0) {
      return filtered.get("firstObject");
    } else {
      var users = Scvrush.Models.User.find({ username: username });

      users.one("didLoad", function() {
        users.resolve(users.get("firstObject"));
      });

      return users;
    }
  }

});
