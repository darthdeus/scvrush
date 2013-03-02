Scvrush.TournamentsNewController = Em.ObjectController.extend({

  create: function(tournament) {
    var self = this;

    tournament.validate().then(function() {
      if (tournament.get("isValid")) {
        tournament.addObserver("id", self, "afterCreate");
        tournament.get("transaction").commit();
      }
    });

  },

  afterCreate: function() {
    this.get("content").removeObserver("id", this, "afterCreate");
    this.transitionToRoute("tournament", this.get("content"));
  }

});
