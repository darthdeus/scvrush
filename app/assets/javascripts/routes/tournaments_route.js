Scvrush.TournamentsIndexRoute = Em.Route.extend({
  model: function() {
    return Scvrush.TournamentDay.find();
  }
});

Scvrush.TournamentsNewRoute = Em.Route.extend({

  model: function() {
    var oneHourFromNow = moment().add("hours", 2);
    return Scvrush.Tournament.createRecord({
      startsAt: oneHourFromNow.format("YYYY-MM-DD HH:mm")
    });
  },

  events: {
    save: function(tournament) {
      var route = this;

      tournament.revalidate();
      if (tournament.get("isInvalid")) {
        return;
      }

      tournament.one("didCreate", function() {
        Ember.run.next(function() {
          route.transitionTo("tournament", tournament);
        });
      });

      tournament.get("transaction").commit();
    }
  }
});

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
      var route = this;

      tournament.one("didDelete", function() {
        route.transitionTo("tournaments");
      });

      tournament.deleteRecord();
      tournament.get("transaction").commit();
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
      tournament.reload();

      $.get("/matches?tournament_id=" + tournament.get("id"), function(data) {
        tournament.get("store").loadMany(Scvrush.Match, data.matches);
      });
    },

    randomize: function(tournament) {
      $.post("/tournaments/" + tournament.get("id") + "/randomize", function(data) {
        tournament.reload();
      })
    },

  }

});
