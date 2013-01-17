Scvrush.Tournament = DS.Model.extend({
  name:              DS.attr("string"),
  imageName:         DS.attr("string"),
  participantCount:  DS.attr("number"),
  startsAt:          DS.attr("string"),
  winner:            DS.belongsTo("Scvrush.User"),
  seeded:            DS.attr("boolean"),
  maxPlayers:        DS.attr("number"),

  user:              DS.belongsTo("Scvrush.User"),
  users:             DS.hasMany("Scvrush.User"),
  brackets:          DS.hasMany("Scvrush.Bracket"),
  isRegistered:      DS.attr("boolean"),
  isChecked:         DS.attr("boolean"),

  tournamentDay: DS.belongsTo("Scvrush.TournamentDay"),
  rounds:            DS.hasMany("Scvrush.Round"),

  startNow: function() {
    var model = this;

    $.post("/tournaments/" + this.get("id") + "/start", function(data) {
      model.get("store").load(Scvrush.Tournament, data.tournament);
    });
  },

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

  isInvalid: function() {
    return this.get("nameInvalid");
  }.property("nameInvalid"),

  revalidate: function () {
    this.notifyPropertyChange("nameInvalid");
  },

  startsAtInvalid: function() {
    return !/^\d{4}-\d{2}-\d{2}[ T]\d{2}:\d{2}(:\d{2})?Z?$/.test(this.get("startsAt"));
  }.property("startsAt"),

  isStarted: function() {
    return new Date(this.get("startsAt")) > new Date();
  }.property("startsAt"),

  shouldCheckin: function() {
    return !this.get("content.isChecked") && this.get("checkinOpen");
  }.property("tournament"),

  checkinOpen: function() {
    var start = moment(this.get("startsAt")),
        checkin = start.subtract("minutes", 30);

    return start < moment() && moment() > checkin;
  }.property("startsAt"),

  isEmpty: function() {
    return !(this.get("participantCount") > 0);
  }.property("participantCount"),

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

});
