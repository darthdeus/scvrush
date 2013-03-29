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

  isMasters: function() {
    return this.get("league") == "masters";
  }.property("league"),

  selectLeague: function(league) {
    this.set("league", league);
    this.get("transaction").commit()
  }

});
