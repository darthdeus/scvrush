Scvrush.Router.map(function(match) {
  match("/").to("home");

  match("/posts").to("posts", function(match) {
    match("/:post_id").to("post");
  });

  match("/tournaments").to("tournaments", function(match) {
    match("/new").to("new");
    match("/:tournament_id").to("show");
  });

  match("/users").to("users", function(match) {
    match("/:user_id").to("user");
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

      if (tournament.get("isInvalid")) {
        return;
      }

      tournament.one("didCreate", function() {
        Ember.run.next(function() {
          router.transitionTo("tournaments.show", tournament);
        });
      });

      this.get("store").commit();
    }
  }
});

Scvrush.UsersIndexRoute = Em.Route.extend({
  model: function() {
    return Scvrush.User.find();
  }
});
