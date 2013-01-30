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
      var router = this;

      tournament.revalidate();
      if (tournament.get("isInvalid")) {
        return;
      }

      tournament.one("didCreate", function() {
        Ember.run.next(function() {
          router.transitionTo("tournament", tournament);
        });
      });

      this.get("store").commit();
    }
  }
});

Scvrush.TournamentsRoute = Em.Route.extend({
  events: {
    register: function(model) {
      if (Scvrush.currentUser.get("isTournamentReady")) {
        model.set("isRegistered", true);
        this.get("store").commit();
      }
    },

    checkin: function(model, user) {
      console.log(user);
      if (Scvrush.currentUser.get("isTournamentReady")) {
        model.set("isChecked", true);
        this.get("store").commit();
      }
    },

    cancel: function(model) {
      model.set("isRegistered", false);
      model.set("isChecked", false);
      this.get("store").commit();
    },

    deleteTournament: function(model) {
      model.deleteRecord();
      this.get("store").commit();
    },

    start: function(model) {
      model.startNow();
    },

    seed: function(tournament) {
      Scvrush.Bracket.createRecord({ tournament: tournament });
      this.get("store").commit();
    },

    unseed: function(tournament) {
      var self = this;
      $.post("/brackets/" + tournament.get("id"), { _method: "DELETE" }, function(data) {
        self.get("store").load(Scvrush.Tournament, data.tournament);
      });
    },

    reloadMatches: function(tournament) {
      var store = this.get("store");

      tournament.reload();

      $.get("/matches?tournament_id=" + tournament.get("id"), function(data) {
        store.loadMany(Scvrush.Match, data.matches);
      });
    },

    randomize: function(tournament) {
      $.post("/tournaments/" + tournament.get("id") + "/randomize", function(data) {
        tournament.reload();
      })
    },

  }

});
