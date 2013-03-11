Scvrush.TournamentsRoute = Em.Route.extend({
  events: {
    register: function(tournament, user) {
      tournament.set("isRegistered", true);
      tournament.get("transaction").commit();
    },

    checkin: function(tournament) {
      if (Scvrush.currentUser.get("isTournamentReady")) {
        tournament.set("isChecked", true);
        tournament.get("transaction").commit();
      }
    },

    cancel: function(tournament) {
      tournament.set("isRegistered", false);
      tournament.set("isChecked", false);
      tournament.get("transaction").commit();
    },

    deleteTournament: function(tournament) {
      if (confirm("Are you sure?")) {
        tournament.one("didDelete", this, function() {
          this.transitionTo("tournaments");
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
      Scvrush.Bracket.randomize(tournament);
    },

  }

});
