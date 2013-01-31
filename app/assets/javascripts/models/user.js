Scvrush.User = DS.Model.extend({
  username:  DS.attr("string"),
  email:     DS.attr("string"),
  race:      DS.attr("string"),
  image:     DS.attr("string"),
  bnetInfo:  DS.attr("string"),
  expiresAt: DS.attr("date"),

  password:  DS.attr("string"),
  passwordConfirmation: DS.attr("string"),

  statuses:  DS.hasMany("Scvrush.Status"),
  followers: DS.hasMany("Scvrush.User"),
  following: DS.hasMany("Scvrush.User"),

  tournaments: DS.hasMany("Scvrush.Tournament"),

  bnetInfoValid: function() {
    return /.+\.\d{3}/.test(this.get("bnetInfo"));
  }.property("bnetInfo"),

  isTournamentReady: function() {
    return !!this.get("bnetInfoValid") && !!this.get("race");
  }.property("bnetInfoValid", "race"),

  isNotTournamentReady: Ember.computed.not("isTournamentReady"),

  hasFollowers: function() {
    if (this.get("followers")) {
      return this.get("followers.length") > 0;
    }
  },

  isTrial: function() {
    return !!this.get("expiresAt");
  }.property("expiresAt"),

  imageOrDefault: function() {
    return this.get("image") || "default.png";
  }.property("image"),

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
      user.get("store").loadMany(Scvrush.User, data.users);
    });
  },

  unfollow: function(user) {
    var url = "/users/" + user.get("id") + "/unfollow";

    $.post(url, { "_method": "DELETE" }, function(data) {
      user.get("store").loadMany(Scvrush.User, data.users);
    });
  },

  isFollowing: function(anotherUser) {
    return this.get("following").contains(anotherUser);
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
      var users = Scvrush.User.find({ username: username });

      users.then(function() {
        users.resolve(users.get("firstObject"));
      });

      return users;
    }
  },

  ALL_RACES: [ "Zerg", "Terran", "Protoss", "Random" ]

});
