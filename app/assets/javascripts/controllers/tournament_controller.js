Scvrush.TournamentController = Ember.ObjectController.extend({

  currentMatch: function() {
    var rounds = this.get("rounds");

    var result = rounds.map(function(round) {
      return round.get("matches").filter(function(match) {
        return match.get("player1") == Scvrush.currentUser.get("bnetInfo")
              || match.get("player2") == Scvrush.currentUser.get("bnetInfo");
      }).get("lastObject");
    }).filter(function(item) {
      return !!item;
    });

    var self = this;
    Ember.run.next(function() {
      self.notifyPropertyChange("currentMatch");
    });

    return result.get("lastObject");
  }.property("rounds.@each.allMatches"),

  currentOpponent: function() {
    var match = this.get("currentMatch");

    if (match) {
      return match.opponentFor(Scvrush.currentUser);
    } else {
      return "";
    }
  }.property("currentMatch"),

  scoreError: function() {
    return !Ember.isEmpty(this.get("score")) && this.get("scoreInvalid");
  }.property("score"),

  scoreInvalid: function() {
    return !/\d:\d/.test(this.get("score"));
  }.property("score"),

  isAdmin: function() {
    return this.get("user") == Scvrush.currentUser;
  }.property("user"),

  isPlaying: function() {
    return this.get("content.users").contains(Scvrush.currentUser);
  }.property("users.@each"),

  allUsers: function() {
    return Scvrush.User.filter(function() { return true });
  }.property(),

  lastUser: function() {
    return this.get("allUsers.lastObject");
  }.property("allUsers.length")

});
