Scvrush.User = DS.Model.extend(Ember.Validations.Mixin, {
  username:  DS.attr("string"),
  email:     DS.attr("string"),
  image:     DS.attr("string"),
  bnetInfo:  DS.attr("string"),
  server:    DS.attr("string"),
  race:      DS.attr("string"),
  league:    DS.attr("string"),
  expiresAt: DS.attr("date"),
  about:     DS.attr("string"),

  password:  DS.attr("string"),
  passwordConfirmation: DS.attr("string"),

  statuses:  DS.hasMany("Scvrush.Status"),

  followers: DS.hasMany("Scvrush.User"),
  followees: DS.hasMany("Scvrush.User"),

  notifications: DS.hasMany("Scvrush.Notification"),
  achievements: DS.hasMany("Scvrush.Achievement"),

  // tournaments: DS.hasMany("Scvrush.Tournament"),
  allTournaments: function() {
    Scvrush.Tournament.query();
  }.property(),

  playingTournaments: function() {
    var user = this;

    return Scvrush.Tournament.filter(function(tournament) {
      return tournament.get("users").contains(user);
    }.bind(this));
  }.property(),

  leagueIcon: function() {
    if (this.get("league")) {
      return "/assets/league_" + this.get("league").toLowerCase() + "_icon.png";
    } else {
      return "/assets/league_bronze_icon.png";
    }
  }.property("race"),

  raceIcon: function() {
    if (this.get("race")) {
      return "/assets/race_" + this.get("race").toLowerCase() + "_icon.png";
    } else {
      return "/assets/race_random_icon.png";
    }
  }.property("race"),

  bnetInfoValid: function() {
    return /^.+\.\d{3,4}$/.test(this.get("bnetInfo"));
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

  currentOpponent: function() {
    return Scvrush.__container__.lookup("controller:tournament.index").get("currentOpponent");
  }.property(),

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
    return this.get("statuses").toArray().reverse().slice(0, 10);
  }.property("statuses.@each.item"),

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
  }

});


var usersSet = new Ember.Set();

usersSet.reopen({
  enumerableContentDidChange: function(start, removing, adding) {
    Scvrush.User.find({ username: removing[0] })
  }
});

Scvrush.User.reopenClass({

  usernameFilter: function(username) {
    return Scvrush.User.filter(function(user) {
      if (username && user.get("username")) {
        return user.get("username").toLowerCase() === username.toLowerCase();
      } else {
        return false;
      }
    })
  },

  checkUsername: function(username) {
    usersSet.addObject(username);
  },

  findByUsername: function(username) {
    var filtered = this.usernameFilter(username).get("firstObject");

    if (filtered) {
      return filtered;
    } else {
      return Scvrush.User.find({ username: username });
    }
  },

  ALL_RACES: [ "Zerg", "Terran", "Protoss", "Random" ]

});
