Scvrush.TournamentEditController = Ember.ObjectController.extend({
  needs: "tournament",

  saveTournament: function(tournament) {
    tournament.one("didUpdate", this, function() {
      Ember.run.next(this, function() {
        this.transitionToRoute("tournament", tournament);
      });
    });

    tournament.get("transaction").commit();
  }
});
