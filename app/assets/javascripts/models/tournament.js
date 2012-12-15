Scvrush.Tournament = DS.Model.extend({
  name: DS.attr("string"),
  tournament_day: DS.belongsTo("Scvrush.TournamentDay")
});

Scvrush.TournamentDay = DS.Model.extend({
  date: DS.attr("string"),
  tournaments: DS.hasMany("Scvrush.Tournament", { embedded: true })
});
