Scvrush.Tournament = DS.Model.extend({
  name:              DS.attr("string"),
  image_name:        DS.attr("string"),
  participant_count: DS.attr("number"),
  starts_at:         DS.attr("string"),

  one_person: function() {
    return this.get("participant_count") == 1;
  }.property("participant_count"),

  image_url: function() {
    return "/assets/" + this.get("image_name");
  }.property("image_name"),

  start_time: function() {
    var time = moment(this.get("starts_at"))
    return time.format("LT") + " (" + time.fromNow() + ")";
  }.property("starts_at"),

  tournament_day: DS.belongsTo("Scvrush.TournamentDay"),
});

Scvrush.TournamentDay = DS.Model.extend({
  date: DS.attr("string"),

  human_date: function() {
    return moment(this.get("date"), "YYYY-MM-DD").format("dddd MMMM Do YYYY");
  }.property("date"),

  tournaments: DS.hasMany("Scvrush.Tournament")
});
