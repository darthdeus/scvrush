Scvrush.RacePickerController = Ember.ObjectController.extend({

  isZerg: function() {
    return this.get("race") == "Zerg";
  }.property("race"),

  isTerran: function() {
    return this.get("race") == "Terran";
  }.property("race"),

  isProtoss: function() {
    return this.get("race") == "Protoss";
  }.property("race"),

  isRandom: function() {
    return this.get("race") == "Random";
  }.property("race"),

  selectRace: function(race) {
    this.set("content.race", race);
  },

});
