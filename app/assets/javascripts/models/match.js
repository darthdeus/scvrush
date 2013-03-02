Scvrush.Match = DS.Model.extend(Ember.Validations.Mixin, {
  number:        DS.attr("number"),
  player1_score:  DS.attr("number"),
  player2_score:  DS.attr("number"),
  score:         DS.attr("string"),
  completed:     DS.attr("boolean"),

  player1: DS.belongsTo("Scvrush.User"),
  player2: DS.belongsTo("Scvrush.User"),

  round: DS.belongsTo("Scvrush.Round"),

  validations: {
    score: {
      format: { with: /^\d:\d$/, allowBlank: true }
    }
  },

  hasPlayer: function(user) {
    var bnet = user.get("bnetInfo");
    return this.get("player1") == bnet || this.get("player2") == bnet;
  },

  opponentFor: function(user) {
    if (this.get("player1") == user) {
      return this.get("player2");
    } else if (this.get("player2") == user) {
      return this.get("player1");
    } else {
      throw new Error("User doesn't exist");
    }
  },

  isPending: function() {
    return !this.get("score") && !!this.get("player1") && !!this.get("player2");
  }.property("player1", "player2", "score"),

});

