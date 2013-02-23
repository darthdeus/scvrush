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
        tournament.deleteRecord();
        tournament.get("transaction").commit();
        this.transitionTo("tournaments");
      }
    },

    start: function(model) {
      model.startNow();
    },

    seed: function(tournament) {
      Scvrush.Bracket.createRecord({ tournament: tournament });
      tournament.get("transaction").commit();
    },

    unseed: function(tournament) {
      $.post("/brackets/" + tournament.get("id"), { _method: "DELETE" }, function(data) {
        tournament.get("store").load(Scvrush.Tournament, data.tournament);
      });
    },

    reloadMatches: function(tournament) {
      Scvrush.TournamentService.reload(tournament);
    },

    randomize: function(tournament) {
      $.post("/tournaments/" + tournament.get("id") + "/randomize", function(data) {
        tournament.reload();
      })
    },

  }

});
