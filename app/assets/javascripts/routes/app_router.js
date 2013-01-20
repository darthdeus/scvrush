Scvrush.Router.map(function() {
  this.route("home", { path: "/" });

  this.resource("posts", { path: "/posts" }, function() {
    this.route("post", { path: "/:post_id" });
  });

  this.resource("tournaments", { path: "/tournaments" }, function() {
    this.resource("tournament", { path: "/:tournament_id" });
    this.route("new", { path: "/new" });
  });

  this.resource("users", { path: "/users" }, function() {
    this.route("user", { path: "/:user_id" });
  });

});

Scvrush.PostsIndexRoute = Em.Route.extend({
  model: function() {
    return Scvrush.Post.find();
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

Scvrush.TournamentRoute = Em.Route.extend({
  renderTemplate: function() {
    this.render("tournaments/tournament");
  },

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
    }
  }
});

Scvrush.UsersIndexRoute = Em.Route.extend({
  model: function() {
    return Scvrush.User.find();
  }
});
