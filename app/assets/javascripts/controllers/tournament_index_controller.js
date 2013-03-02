Scvrush.TournamentIndexController = Ember.ObjectController.extend({

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
    return this.get("currentMatch.winner") !== Scvrush.currentUser && this.get("currentMatch.winner");
  }.property("currentMatch.score"),

  lostAgainst: function() {
    return this.get("currentMatch.winner");
  }.property("currentMatch.score"),

  currentMatch: function() {
    var rounds = this.get("rounds");

    var result = rounds.map(function(round) {
      return round.get("matches").filter(function(match) {
        return match.get("player1") == Scvrush.currentUser
              || match.get("player2") == Scvrush.currentUser;
      }).get("lastObject");
    }).filter(function(item) {
      return !!item;
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
  }.property("users.@each.id"),

  lastUser: function() {
    return this.get("allUsers.lastObject");
  }.property("allUsers.length")

});
