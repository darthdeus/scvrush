Scvrush.Router.map(function() {
  this.route("home", { path: "/" });

  this.resource("posts", { path: "/posts" }, function() {
    this.route("post", { path: "/:post_id" });
  });

  this.resource("tournaments", { path: "/tournaments" }, function() {
    this.route("new", { path: "/new" });

    this.resource("tournament", { path: "/:tournament_id" }, function() {
      this.resource("matches", { path: "/matches" }, function() {
        this.resource("match", { path: "/:match_id" }, function() {
          this.route("edit", { path: "/edit" });
        });
      });
    });
  });


  this.resource("users", { path: "/users" }, function() {
    this.route("user", { path: "/:user_id" });
  });

});

// Scvrush.PostsIndexRoute = Em.Route.extend({
//   model: function() {
//     return Scvrush.Post.find();
//   }
// });

Scvrush.TournamentsRoute = Em.Route.extend({
  events: {
    register: function(model) {
      model.set("isRegistered", true);
      this.get("store").commit();
    },

    checkin: function(model) {
      model.set("isChecked", true);
      this.get("store").commit();
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

Scvrush.TournamentIndexRoute = Em.Route.extend({

  events: {
    submitResult: function(score, opponentId) {
      var controller = this.controllerFor("tournamentIndex"),
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
    }
  }
});

Scvrush.MatchEditRoute = Ember.Route.extend({
  setupController: function(controller, model) {
    controller.set("model", this.controllerFor("match").get("content"));
  }
});

Scvrush.UsersIndexRoute = Em.Route.extend({
  model: function() {
    return Scvrush.User.find();
  }
});
