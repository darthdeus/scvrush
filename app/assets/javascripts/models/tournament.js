Scvrush.Tournament = DS.Model.extend({
  name:              DS.attr("string"),
  imageName:         DS.attr("string"),
  participantCount:  DS.attr("number"),
  startsAt:          DS.attr("string"),
  winner:            DS.belongsTo("Scvrush.User"),
  seeded:            DS.attr("boolean"),

  users:             DS.hasMany("Scvrush.User"),
  brackets:          DS.hasMany("Scvrush.Bracket"),
  isRegistered:      DS.attr("boolean"),

  rounds:            DS.hasMany("Scvrush.Round"),

  isStarted: function() {
    return new Date(this.get("startsAt")) < new Date();
  }.property("startsAt"),

  hasRounds: function() {
    return this.get("rounds.length") > 0;
  }.property("rounds.@each"),

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

  startTime: function() {
    var time = moment(this.get("startsAt"))
    if (!time) { return ""; }
    return time.format("LT") + " (" + time.fromNow() + ")";
  }.property("startsAt"),

  tournamentDay: DS.belongsTo("Scvrush.TournamentDay")
});
