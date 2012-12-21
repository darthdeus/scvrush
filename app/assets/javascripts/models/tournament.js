Scvrush.Tournament = DS.Model.extend({
  name:              DS.attr("string"),
  image_name:        DS.attr("string"),
  participant_count: DS.attr("number"),
  starts_at:         DS.attr("string"),
  winner:            DS.belongsTo("Scvrush.User"),

  users:             DS.hasMany("Scvrush.User"),

  is_registered:     DS.attr("boolean"),

  is_started: function() {
    return new Date(this.get("starts_at")) < new Date();
  }.property("starts_at"),

  is_finished: function() {
    return this.get("winner_id") !== null;
  }.property("winner_id"),

  one_person: function() {
    return this.get("participant_count") == 1;
  }.property("participant_count"),

  image_url: function() {
    return "/assets/" + this.get("image_name");
  }.property("image_name"),

  start_time: function() {
    var time = moment(this.get("starts_at"))
    if (!time) { return ""; }
    return time.format("LT") + " (" + time.fromNow() + ")";
  }.property("starts_at"),

  tournament_day: DS.belongsTo("Scvrush.TournamentDay")
});
