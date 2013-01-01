Scvrush.User = DS.Model.extend({
  username:  DS.attr("string"),
  race:      DS.attr("string"),
  image:     DS.attr("string"),
  bnet_info: DS.attr("string"),

  statuses:   DS.hasMany("Scvrush.Status"),
  followers:  DS.hasMany("Scvrush.User"),
  following: DS.hasMany("Scvrush.User"),

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

    // TODO - error handling
    $.post(url, function(data) {
      Scvrush.store.loadMany(Scvrush.User, data.users);
    });
  },

  unfollow: function(user) {
    var url = "/users/" + user.get("id") + "/unfollow";

    // TODO - error handling
    $.post(url, { "_method": "DELETE" }, function(data) {
      Scvrush.store.loadMany(Scvrush.User, data.users);
    });
  },

  lowerUsername: function() {
    if (this.get("username")) {
      return this.get("username").toLowerCase()
    }
  }.property("username"),

  isFollowing: function(anotherUser) {
    return this.get("following").contains(anotherUser.get("id"));
  },

});


Scvrush.User.reopenClass({

  findByUsername: function(username) {
    var filtered = Scvrush.store.filter(Scvrush.User, function(user) {
      return user.username == username;
    });

    if (filtered.get("length") > 0) {
      return filtered.get("firstObject");
    } else {
      return Scvrush.store.find(Scvrush.User, { username: username });
    }
  }

});
