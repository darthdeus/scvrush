Scvrush.RoundItemController = Ember.ObjectController.extend({

  needs: ["tournament", "tournamentIndex"],
  adminView: false,
  adminViewBinding: "controllers.tournament.adminView",

  indexNumber: function() {
    window.a = this;
    return this.get("controllers.tournament.rounds").indexOf(this.get("content"));
  }.property("content"),

  indexClass: function() {
    return "round-" + this.get("indexNumber");
  }.property("indexNumber"),

});
