Scvrush.Round = DS.Model.extend({
  number: DS.attr("number"),
  matches: DS.hasMany("Scvrush.Match")
});

Scvrush.Match = DS.Model.extend({
  player1: DS.attr("string"),
  player2: DS.attr("string"),
  player1_score: DS.attr("number"),
  player2_score: DS.attr("number"),
  completed: DS.attr("boolean"),
  round: DS.belongsTo("Scvrush.Round")
});
