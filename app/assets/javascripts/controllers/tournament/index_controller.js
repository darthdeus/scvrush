Scvrush.TournamentIndexController = Ember.ObjectController.extend({

  adminView: false,

  submitResult: function(score, opponent) {
    if (this.get("scoreInvalid")) {
      return;
    }

    // TODO - also validate the opposite case of user submitting
    // score as if he lost, like 1:3

    $.ajax({
      url: "/matches",
      method: "post",
      data: {
        score: score,
        opponent_id: opponent.get("id"),
        tournament_id: this.get("content.id")
      },
      context: this,
      success: this._matchSubmitted
    });
  },

  _matchSubmitted: function(data) {
    Ember.run(this, function() {
      this.get("store").loadMany(Scvrush.Match, data.matches);
    });
  },

  isLost: function() {
    return this.get("currentMatch.winner") !== Scvrush.currentUser.get("content")
            && this.get("currentMatch.winner");
  }.property("currentMatch.score"),

  lostAgainst: function() {
    return this.get("currentMatch.winner");
  }.property("currentMatch.score"),

  currentMatch: function() {
    var rounds = this.get("rounds");

    if (!rounds) return null;

    var result = rounds.map(function(round) {
      return round.get("matches").filter(function(match) {
        return match.get("player1") === Scvrush.currentUser.get("content")
              || match.get("player2") === Scvrush.currentUser.get("content");
      }).get("lastObject");
    }).filter(function(item) {
      return !!item;
    });

    return result.get("lastObject");
  }.property("rounds.@each.allMatches"),

  currentOpponent: function() {
    var match = this.get("currentMatch"),
        value = null

    if (match) {
      value = match.opponentFor(Scvrush.currentUser.get("content"));
    }

    Scvrush.currentUser.set("currentOpponent", value);

    return value;
  }.property("currentMatch"),

  currentMatchChanged: function() {
    Scvrush.currentUser.notifyPropertyChange("currentOpponent");
  }.observes("currentMatch"),

  currentTournament: function() {
    return this.get("currentMatch.round.tournament");
  }.property("currentMatch"),

  scoreError: function() {
    return !Ember.isEmpty(this.get("score")) && this.get("scoreInvalid");
  }.property("score"),

  scoreInvalid: function() {
    return !/\d:\d/.test(this.get("score"));
  }.property("score"),

  isAdmin: function() {
    return this.get("user") == Scvrush.currentUser.get("content");
  }.property("user"),

  isPlaying: function() {
    return this.get("content.users").contains(Scvrush.currentUser.get("content"));
  }.property("users.@each.id"),

  lastUser: function() {
    return this.get("allUsers.lastObject");
  }.property("allUsers.length"),

  canParticipate: function() {
    return this.get("leagues").split(",").contains(Scvrush.currentUser.get("league")) &&
      this.get("region") === Scvrush.currentUser.get("server");
  }.property("leagues", "region", "Scvrush.currentUser.league", "Scvrush.currentUser.server")

});
