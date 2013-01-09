Scvrush.Router.map(function(match) {
  match("/").to("home");

  // match("/posts").to("posts", function(match) {
  //   match("/").to("posts");
  //   match("/:post_id").to("post");
  // });

  // match("/tournaments").to("tournaments", function(match) {
  //   match("/").to("tournamentsIndex");
  //   match("/new").to("tournamentsNew");
  //   match("/:tournament_id").to("tournament");
  // });

  // match("/users").to("users", function(match) {
  //   match("/").to("users");
  //   match("/:user_username").to("user");
  // });
});

// Scvrush.PostsRoute = Em.Route.extend({
//   setupController: function(controller, model) {
//     controller.set("content", Scvrush.Post.find());
//   }
// });
//
// Scvrush.TournamentsIndexRoute = Em.Route.extend({
//   setupController: function(controller, model) {
//     controller.set("content", Scvrush.TournamentDay.find());
//   }
// });
//
// Scvrush.TournamentsNewRoute = Em.Route.extend({
//   model: function() {
//     var oneHourFromNow = moment().add("hours", 2);
//     return Scvrush.Tournament.createRecord({
//       startsAt: oneHourFromNow.format("YYYY-MM-DD HH:mm")
//     });
//   }
// });
//
// Scvrush.UserRoute = Em.Route.extend({
//   model: function(params) {
//     return Scvrush.User.findByUsername(params.user_username);
//   },
//
//   serialize: function(user, params) {
//     return { user_username: Ember.get(user, "username") };
//   }
// });
//
// Scvrush.UsersRoute = Em.Route.extend({
//   setupController: function(controller, model) {
//     controller.set("content", Scvrush.User.find());
//   }
// });
//
