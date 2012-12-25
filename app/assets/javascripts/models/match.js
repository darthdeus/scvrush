Scvrush.Match = DS.Model.extend({
  number:        DS.attr("number"),
  player1:       DS.attr("string"),
  player2:       DS.attr("string"),
  player1_score: DS.attr("number"),
  player2_score: DS.attr("number"),
  completed:     DS.attr("boolean"),

  round: DS.belongsTo("Scvrush.Round")
});

