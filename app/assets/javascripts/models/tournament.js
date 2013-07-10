Scvrush.Tournament = DS.Model.extend(Ember.Validations.Mixin, {
  name:              DS.attr("string"),
  imageName:         DS.attr("string"),
  signupsCount:      DS.attr("number"),
  startsAt:          DS.attr("string"),
  seeded:            DS.attr("boolean"),
  maxPlayers:        DS.attr("number"),
  leagues:           DS.attr("string"),
  region:            DS.attr("string"),
  mapInfo:           DS.attr("string"),
  rules:             DS.attr("string"),
  mapPreset:         DS.attr("string"),
  boPreset:          DS.attr("string"),

  isRegistered:      DS.attr("boolean"),
  isChecked:         DS.attr("boolean"),
  channel:           DS.attr("string"),
  description:       DS.attr("string"),

  winner:            DS.belongsTo("Scvrush.User"),
  user:              DS.belongsTo("Scvrush.User"),
  users:             DS.hasMany("Scvrush.User"),
  signups:           DS.hasMany("Scvrush.Signup"),

  rounds:            DS.hasMany("Scvrush.Round"),

  validations: {
    name: {
      presence: true,
      length: { minimum: 6, maximum: 50 }
    },
  },

  startDay: function() {
    return moment(this.get("startsAt")).utc().format("dddd, MMMM D, YYYY");
  }.property("startsAt"),

  startNow: function() {
    var model = this;

    $.post("/api/tournaments/" + this.get("id") + "/start", function(data) {
      Ember.run(function() {
        model.get("store").load(Scvrush.Tournament, data.tournament);
      });
    });
  },

  emails: function() {
    var self = this;

    $.getJSON("/api/tournaments/" + this.get("id") + "/emails.json", function(data) {
      self.set("emails", data);
      self.propertyDidChange("emails");
    });

    return [];
  }.property("id"),

  reverseRounds: function() {
    return this.get("rounds");
  }.property("rounds.@each"),

  startsAtInvalid: function() {
    return !/^\d{4}-\d{2}-\d{2}[ T]\d{2}:\d{2}(:\d{2})?Z?$/.test(this.get("startsAt"));
  }.property("startsAt"),

  isStarted: function() {
    var start = moment.utc(this.get("startsAt"));
    var now = moment.utc();

    return start.isBefore(now)
  }.property("startsAt"),

  shouldCheckin: function() {
    return !this.get("isChecked") && this.get("checkinOpen");
  }.property("startsAt"),

  checkinOpen: function() {
    var start = moment.utc(this.get("startsAt")),
        checkin = start.subtract("minutes", 30);

    return start < moment.utc() && moment.utc() > checkin;
  }.property("startsAt"),

  isEmpty: function() {
    return !(this.get("signupsCount") > 0);
  }.property("signupsCount"),

  hasRounds: function() {
    return this.get("rounds.length") > 0;
  }.property("rounds.@each"),

  isOpen: function() {
    return !this.get("isStarted");
  }.property("startsAt"),

  hasWinner: function() {
    return this.get("winnerId") !== null;
  }.property("winnerId"),

  onePerson: function() {
    return this.get("signupsCount") == 1;
  }.property("signupsCount"),

  imageUrl: function() {
    return "/assets/" + this.get("imageName");
  }.property("imageName"),

  startTime: function() {
    var time = moment.utc(this.get("startsAt"))
    if (!time) { return ""; }
    return time.format("LT") + " (" + time.fromNow() + ")";
  }.property("startsAt"),

  untilStart: function() {
    return moment.utc().diff(moment.utc(this.get("startsAt"))) > 0;
  }.property("startsAt"),

  startTimeFull: function() {
    return moment.utc(this.get("startsAt"));
  }.property("startsAt"),

  currentUserTime: function() {
    return moment.utc();
  }.property(),

  currentUserTimeUTC: function() {
    return moment.utc();
  }.property(),

});

Scvrush.Tournament.reopenClass({
  REGIONS: ["EU", "NA", "KR", "SEA"],

  featuredTournament: function() {
    return Scvrush.Tournament.query();
  }

});
