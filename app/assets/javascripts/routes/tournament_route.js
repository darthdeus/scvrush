Scvrush.TournamentRoute = Ember.Route.extend({

  events: {
    submitResult: function(score, opponentId) {
      var controller = this.controllerFor("tournament"),
          route = this;

      controller.propertyDidChange("score");

      if (controller.get("scoreInvalid")) {
        return;
      }

      // TODO - also validate the opposite case of user submitting
      // score as if he lost, like 1:3

      $.post("/matches", {
        score: score,
        opponent_id: opponentId,
        tournament_id: controller.get("content.id")
      }, function(data) {
        route.get("store").loadMany(Scvrush.Match, data.matches);
      });
      console.log("submitted", score);
    },

    adminEdit: function(match) {
      // TODO - if admin
      this.transitionTo("match.edit", match);
    },

    saveMatch: function(match) {
      match.get("store").commit();
    },

  }

});

Scvrush.TournamentEditRoute = Ember.Route.extend({

  events: {
    saveTournament: function(tournament) {
      var route = this;

      tournament.one("didUpdate", function() {
        Ember.run.next(function() {
          route.transitionTo("tournament.index", tournament);
        });
      });

      tournament.get("transaction").commit();
    }
  },

  activate: function() {
    var tournament = this.modelFor("tournament"),
        transaction = tournament.get("store").transaction();

    transaction.add(tournamnet);
  },

  deactivate: function() {
    this.modelFor("tournament").get("transaction").rollback();
  }

});
