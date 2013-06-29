Scvrush.TournamentAdminBoxController = Ember.ObjectController.extend({

  deleteTournament: function(tournament) {
    if (confirm("Are you sure?")) {
      tournament.one("didDelete", this, function() {
        this.transitionToRoute("tournaments");
      });

      tournament.deleteRecord();
      tournament.get("transaction").commit();
    }
  },

  start: function(model) {
    model.startNow();
  },

  seed: function(tournament) {
    Scvrush.Bracket.seed(tournament);
  },

  unseed: function(tournament) {
    Scvrush.Bracket.unseed(tournament);
  },

  randomize: function(tournament) {
    if (confirm("Are you sure? This will remove all of the current signups")) {
      Scvrush.Bracket.randomize(tournament);
    }
  },


});
