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
    foo: function() {
      console.log("from the router", this.get("store").toString());
    }
  }
});

Scvrush.UsersIndexRoute = Em.Route.extend({
  model: function() {
    return Scvrush.User.find();
  }
});
