Scvrush.TournamentsNewController = Em.ObjectController.extend({

  selectedLeagues: null,

  init: function() {
    this._super();
    this.set("selectedLeagues", new Ember.Set());
  },

  create: function(tournament) {
    var self = this;

    tournament.validate().then(function() {
      var leagues = self.selectedLeagues.toArray().join(",");
      tournament.set("leagues", leagues);

      if (tournament.get("isValid")) {
        tournament.addObserver("id", self, "afterCreate");
        tournament.get("transaction").commit();
      }
    });
  },

  afterCreate: function() {
    this.get("content").removeObserver("id", this, "afterCreate");
    this.transitionToRoute("tournament", this.get("content"));
  },

  toggle: function(league) {
    var set = this.get("selectedLeagues");

    if (set.contains(league)) {
      set.remove(league);
    } else {
      set.add(league);
    }
  },

  selectedBronze: function() {
    return this.get("selectedLeagues").contains("Bronze");
  }.property("selectedLeagues.length"),

  selectedSilver: function() {
    return this.get("selectedLeagues").contains("Silver");
  }.property("selectedLeagues.length"),

  selectedGold: function() {
    return this.get("selectedLeagues").contains("Gold");
  }.property("selectedLeagues.length"),

  selectedPlatinum: function() {
    return this.get("selectedLeagues").contains("Platinum");
  }.property("selectedLeagues.length"),

  selectedDiamond: function() {
    return this.get("selectedLeagues").contains("Diamond");
  }.property("selectedLeagues.length"),

  selectedMaster: function() {
    return this.get("selectedLeagues").contains("Master");
  }.property("selectedLeagues.length"),

});
