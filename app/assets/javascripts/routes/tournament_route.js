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
        Ember.run(function() {
          route.get("store").loadMany(Scvrush.Match, data.matches);
        });
      });
      console.log("submitted", score);
    }

  },

  setupController: function(controller, model) {
    // this.set("reloader", setInterval(function() {
    //   model.reload();
    // }, 10000));
  },

  deactivate: function() {
    // clearInterval(this.get("reloader"));
  }

});

Scvrush.TournamentIndexRoute = Ember.Route.extend({

  model: function() {
    return this.modelFor("tournament");
  }

});
