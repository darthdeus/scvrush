Scvrush.RoundItemController = Ember.ObjectController.extend({

  needs: "tournament",

  indexNumber: function() {
    return this.get("controllers.tournament.rounds").indexOf(this.get("content"));
  }.property("content"),

  indexClass: function() {
    return "round-" + this.get("indexNumber");
  }.property("indexNumber"),

  init: function() {
    this._super();
  }

});
