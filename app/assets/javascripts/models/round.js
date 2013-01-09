Scvrush.Models.Round = DS.Model.extend({
  number:     DS.attr("number"),
  tournament: DS.belongsTo("Scvrush.Models.Tournament"),
  matches:    DS.hasMany("Scvrush.Models.Match")
});
