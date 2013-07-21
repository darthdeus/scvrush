Scvrush.Match = DS.Model.extend(Ember.Validations.Mixin, {
  number:        DS.attr("number"),
  player1_score: DS.attr("number"),
  player2_score: DS.attr("number"),
  score:         DS.attr("string"),
  completed:     DS.attr("boolean"),
  updatedAt:     DS.attr("date"),

  player1: DS.belongsTo("Scvrush.User"),
  player2: DS.belongsTo("Scvrush.User"),

  round: DS.belongsTo("Scvrush.Round"),

  validations: {
    score: {
      format: { with: /^\d:\d$/, allowBlank: true }
    }
  },

  updatedAtHuman: function() {
    if (this.get("updatedAt")) {
      return moment(this.get("updatedAt")).utc().fromNow();
    }
  }.property("updatedAt"),

  players: function() {
    return this.get("round.tournament.users");
  }.property("round.tournament.users.[]"),

  isLost: function() {
    return this.get("winner") !== Scvrush.currentUser.get("content");
  }.property("winner"),

  hasPlayer: function(user) {
    var bnet = user.get("bnetInfo");
    return this.get("player1") == bnet || this.get("player2") == bnet;
  },

  opponentFor: function(user) {
    if (this.get("player1") === user) {
      return this.get("player2");
    } else if (this.get("player2") === user) {
      return this.get("player1");
    } else {
      throw new Error("User doesn't exist");
    }
  },

  winner: function() {
    if (this.get("score")) {
      var score = this.get("score").split(":");

      if (score[0] > score[1]) {
        return this.get("player1");
      } else {
        return this.get("player2");
      }
    }
  }.property("score"),

  isPending: function() {
    return !this.get("score") && !!this.get("player1") && !!this.get("player2");
  }.property("player1", "player2", "score"),

  isDone: function() {
    return !!this.get("score");
  }.property("isPending", "player1", "player2", "score")

});

