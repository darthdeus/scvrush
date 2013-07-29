Scvrush.TournamentIndexController = Ember.ObjectController.extend({
  adminView: false,

  submitResult: function(score, opponent) {
    if (this.get("scoreInvalid")) {
      return;
    }

    // TODO - also validate the opposite case of user submitting
    // score as if he lost, like 1:3

    $.ajax({
      url: "/api/matches",
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
      this.get("store").loadMany(Scvrush.Tournament, data.tournaments);
      Scvrush.currentUser.reload();
      console.log(data.tournament);
    });
  },

  isLost: function() {
    return this.get("currentMatch.winner") !== Scvrush.currentUser.get("content")
            && this.get("currentMatch.winner");
  }.property("currentMatch.score"),

  lostAgainst: function() {
    return this.get("currentMatch.winner");
  }.property("currentMatch.score"),

  mapPool: function() {
    return this.get("currentMatch.round.mapPool");
  }.property("currentMatch"),

  bo: function() {
    return this.get("currentMatch.round.bo");
  }.property("currentMatch"),

  currentMatch: function() {
    var rounds = this.get("rounds");

    if (!rounds) return null;

    rounds = rounds.toArray().sort(function(a, b) {
      return a.get("number") < b.get("number");
    });

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
    return this.get("user") == Scvrush.currentUser.get("content") || Scvrush.currentUser.get("tournamentAdmin");
  }.property("user", "Scvrush.currentUser.tournamentAdmin"),

  isPlaying: function() {
    return this.get("content.users").contains(Scvrush.currentUser.get("content"));
  }.property("users.@each.id"),

  lastUser: function() {
    return this.get("allUsers.lastObject");
  }.property("allUsers.length"),

  canParticipate: function() {
    if (this.get("leagues")) {
      return this.get("leagues").split(",").contains(Scvrush.currentUser.get("league")) &&
        this.get("region") === Scvrush.currentUser.get("server");
    } else {
      return true;
    }
  }.property("leagues", "region", "Scvrush.currentUser.league", "Scvrush.currentUser.server")

});
