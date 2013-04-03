Scvrush.UserLeaguePickerController = Ember.ObjectController.extend({

  isBronze: function() {
    return this.get("league") == "bronze";
  }.property("league"),

  isSilver: function() {
    return this.get("league") == "silver";
  }.property("league"),

  isGold: function() {
    return this.get("league") == "gold";
  }.property("league"),

  isPlatinum: function() {
    return this.get("league") == "platinum";
  }.property("league"),

  isDiamond: function() {
    return this.get("league") == "diamond";
  }.property("league"),

  isMaster: function() {
    return this.get("league") == "master";
  }.property("league"),

  isGrandmaster: function() {
    return this.get("league") == "grandmaster";
  }.property("league"),

  selectLeague: function(league) {
    this.set("league", league);
    this.get("transaction").commit()
  }

});
