Scvrush.Tournament = DS.Model.extend({
  name:              DS.attr("string"),
  imageName:        DS.attr("string"),
  participantCount: DS.attr("number"),
  startsAt:         DS.attr("string"),
  winner:            DS.belongsTo("Scvrush.User"),
  seeded:            DS.attr("boolean"),

  users:             DS.hasMany("Scvrush.User"),
  brackets:          DS.hasMany("Scvrush.Bracket"),
  is_registered:     DS.attr("boolean"),

  rounds:            DS.hasMany("Scvrush.Round"),

  isStarted: function() {
    return new Date(this.get("startsAt")) < new Date();
  }.property("startsAt"),

  isOpen: function() {
    return !(new Date(this.get("startsAt")) < new Date());
  }.property("startsAt"),

  // isFinishedBinding: Em.Binding.not("isStarted"),

  hasWinner: function() {
    return this.get("winnerId") !== null;
  }.property("winnerId"),

  onePerson: function() {
    return this.get("participantCount") == 1;
  }.property("participantCount"),

  imageUrl: function() {
    return "/assets/" + this.get("imageName");
  }.property("imageName"),

  start_time: function() {
    var time = moment(this.get("starts_at"))
    if (!time) { return ""; }
    return time.format("LT") + " (" + time.fromNow() + ")";
  }.property("startsAt"),

  tournament_day: DS.belongsTo("Scvrush.TournamentDay")
});
