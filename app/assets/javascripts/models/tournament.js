Scvrush.Tournament = DS.Model.extend({
  name: DS.attr("string"),

  tournament_day: DS.belongsTo("Scvrush.TournamentDay"),

});

Scvrush.TournamentDay = DS.Model.extend({
  date: DS.attr("string"),

  human_date: function() {
    return moment(this.get("date"), "YYYY-MM-DD").format("dddd MMMM Do YYYY");
  }.property("date"),

  tournaments: DS.hasMany("Scvrush.Tournament", { embedded: true })
});
