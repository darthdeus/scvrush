Scvrush.Router.map(function(match) {
  match("/").to("home");

  match("/posts").to("posts", function(match) {
    match("/:post_id").to("show");
  });

  match("/tournaments").to("tournaments", function(match) {
    match("/new").to("new");
    match("/:tournament_id").to("show");
  });

  match("/users").to("users", function(match) {
    match("/:user_username").to("show");
  });
});

Scvrush.PostsRoute = Em.Route.extend({
  setupController: function(controller, model) {
    controller.set("content", Scvrush.Post.find());
  }
});

Scvrush.TournamentsRoute = Em.Route.extend({
  setupController: function(controller, model) {
    controller.set("content", Scvrush.TournamentDay.find());
  }
});

Scvrush.Tournaments.NewRoute = Em.Route.extend({
  model: function() {
    var oneHourFromNow = moment().add("hours", 2);
    return Scvrush.Tournament.createRecord({
      startsAt: oneHourFromNow.format("YYYY-MM-DD HH:mm")
    });
  }
});

Scvrush.UsersRoute = Em.Route.extend({
  setupController: function(controller, model) {
    controller.set("content", Scvrush.User.find());
  }
});

Scvrush.Users.ShowRoute = Em.Route.extend({
  model: function(params) {
    return Scvrush.User.findByUsername(params.user_username);
  },

  serialize: function(user, params) {
    return { user_username: Ember.get(user, "username") };
  }
});
