Scvrush.Tournament = DS.Model.extend({
  name:              DS.attr("string"),
  imageName:         DS.attr("string"),
  participantCount:  DS.attr("number"),
  startsAt:          DS.attr("string"),
  winner:            DS.belongsTo("Scvrush.User"),
  seeded:            DS.attr("boolean"),
  maxPlayers:        DS.attr("number"),

  users:             DS.hasMany("Scvrush.User"),
  brackets:          DS.hasMany("Scvrush.Bracket"),
  isRegistered:      DS.attr("boolean"),

  rounds:            DS.hasMany("Scvrush.Round"),

  increaseRounds: function() {
    var rounds = this.get("rounds"),
        newRound;

    if (rounds.get("length") == 0) {
      newRound = Scvrush.Round.createRecord({ number: 2 });
    } else {
      var lastRoundNumber = rounds.get("lastObject.number");
      newRound = Scvrush.Round.createRecord({ number: lastRoundNumber * 2 });
    }

    rounds.pushObject(newRound);
  },

  reverseRounds: function() {
    return this.get("rounds");
  }.property("rounds.@each"),

  nameInvalid: function() {
    return this.get("name.length") < 3;
  }.property("name"),

  startsAtInvalid: function() {
    return !/^\d{4}-\d{2}-\d{2}[ T]\d{2}:\d{2}(:\d{2})?Z?$/.test(this.get("startsAt"));
  }.property("startsAt"),

  isStarted: function() {
    return new Date(this.get("startsAt")) < new Date();
  }.property("startsAt"),

  hasRounds: function() {
    return this.get("rounds.length") > 0;
  }.property("rounds.@each"),

  isOpen: function() {
    return !(new Date(this.get("startsAt")) < new Date());
  }.property("startsAt"),

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
