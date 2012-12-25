Scvrush.Round = DS.Model.extend({
  number:     DS.attr("number"),
  tournament: DS.belongsTo("Scvrush.Tournament"),
  matches:    DS.hasMany("Scvrush.Match")
});
