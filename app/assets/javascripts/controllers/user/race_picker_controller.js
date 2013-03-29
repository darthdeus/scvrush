Scvrush.UserRacePickerController = Ember.ObjectController.extend({

  isZerg: function() {
    return this.get("race") == "zerg";
  }.property("race"),

  isTerran: function() {
    return this.get("race") == "terran";
  }.property("race"),

  isProtoss: function() {
    return this.get("race") == "protoss";
  }.property("race"),

  isRandom: function() {
    return this.get("race") == "random";
  }.property("race"),

  selectRace: function(race) {
    this.set("race", race);
    this.get("transaction").commit()
  }

});
