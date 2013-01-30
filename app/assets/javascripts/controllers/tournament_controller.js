Scvrush.TournamentController = Em.ObjectController.extend({

  currentMatch: function() {
    var rounds = this.get("content.rounds");

    var result = rounds.map(function(round) {
      return round.get("matches").filter(function(match) {
        return match.get("player1") == Scvrush.currentUser.get("bnetInfo");
      }).get("lastObject");
    }).filter(function(item) {
      return !!item;
    });

    return result.get("lastObject");
  }.property("content.rounds.@each.allMatches"),

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
    return this.get("content.user") == Scvrush.currentUser;
  }.property("content.user"),

  isPlaying: function() {
    return this.get("content.users").contains(Scvrush.currentUser);
  }.property("content.users.@each"),

});
