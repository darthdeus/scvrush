Scvrush.TournamentsNewController = Em.ObjectController.extend({

  create: function(tournament) {
    tournament.revalidate();
    if (tournament.get("isInvalid")) {
      return;
    }

    tournament.addObserver("id", this, "afterCreate");
    tournament.get("transaction").commit();
  },

  afterCreate: function() {
    this.get("content").removeObserver("id", this, "afterCreate");
    this.transitionToRoute("tournament", this.get("content"));
  }

});
