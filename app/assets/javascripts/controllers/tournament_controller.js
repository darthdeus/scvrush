Scvrush.TournamentController = Em.ObjectController.extend({

  seed: function() {
    Scvrush.Bracket.createRecord({ tournament: this.get("content") });
    this.get("store").commit();
  },

  unseed: function(event) {
    var self = this;
    $.post("/brackets/" + this.get("content.id"), { _method: "DELETE" }, function(data) {
      self.get("store").load(Scvrush.Tournament, data.tournament);
    });
  },

  currentMatch: function() {
    var rounds = this.get("content.rounds");

    var result = window.r = rounds.map(function(round) {
      return round.get("matches").filter(function(match) {
        return match.get("player1") == "darthdeus.989";
      }).get("firstObject");
    });

    return result.get("firstObject");
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

  start: function() {
    this.get("content").startNow();
  },

  isPlaying: function() {
    return this.get("content.users").contains(Scvrush.currentUser);
  }.property("content.users.@each"),

});
