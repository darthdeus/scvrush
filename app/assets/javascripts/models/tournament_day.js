Scvrush.Models.TournamentDay = DS.Model.extend({
  date: DS.attr("string"),

  humanDate: function() {
    return moment(this.get("date"), "YYYY-MM-DD").format("dddd MMMM Do YYYY");
  }.property("date"),

  tournaments: DS.hasMany("Scvrush.Models.Tournament")
});
