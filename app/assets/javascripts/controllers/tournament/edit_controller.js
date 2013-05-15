Scvrush.TournamentEditController = Ember.ObjectController.extend({
  needs: "tournament",

  notSavable: function() {
    return !this.get("isDirty") || this.get("isSaving");
  }.property("isUpdating", "isDirty"),

  saveTournament: function(tournament) {
    tournament.one("didUpdate", this, function() {
      Ember.run.next(this, function() {
        this.transitionToRoute("tournament", tournament);
      });
    });

    tournament.get("transaction").commit();
  }
});
