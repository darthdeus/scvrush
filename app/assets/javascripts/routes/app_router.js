Scvrush.Router = Ember.Router.extend({
  location: "hash",
  enableLogging: true,
});

Scvrush.Router.map(function(match) {
  match("/").to("home");

  match("/posts").to("posts", function(match) {
    match("/").to("postsIndex");
    match("/:post_id").to("postsShow");
  });

  match("/tournaments").to("tournaments", function(match) {
    match("/").to("tournaments");
    match("/:tournament_id").to("tournament");
  });

  match("/users").to("users", function(match) {
    match("/").to("users");
    match("/:user_id").to("user");
  });
});

Scvrush.PostsIndexRoute = Em.Route.extend({
  setupControllers: function(controller, model) {
    controller.set("content", Scvrush.Post.find());
  }
});

Scvrush.PostsShowRoute = Em.Route.extend({
});

Scvrush.TournamentsRoute = Em.Route.extend({
  setupControllers: function(controller, model) {
    controller.set("content", Scvrush.TournamentDay.find());
  }
});

Scvrush.UsersRoute = Em.Route.extend({
  setupControllers: function(controller, model) {
    controller.set("content", Scvrush.User.find());
  }
});

// Scvrush.UserRoute = Em.Route.extend({
//   model: function(params) {
//     return Scvrush.User.find({ username: params.user_username });
//   }
// });



// Scvrush.Routers = Ember.Router.extend({
//   location: 'hash',
//   enableLogging: true,
//
//   root: Em.Route.extend({
//     gotoHome:  Em.Route.transitionTo("root.index"),
//     gotoUsers: Em.Route.transitionTo("users.index"),
//     showUser:  Em.Route.transitionTo("users.show"),
//
//     gotoPosts: Em.Route.transitionTo("posts.index"),
//     showPost:  Em.Route.transitionTo("posts.show"),
//
//     gotoTournaments: Em.Route.transitionTo("tournaments.index"),
//     gotoUserTournaments: Em.Route.transitionTo("tournaments.user"),
//     showTournament: Em.Route.transitionTo("tournaments.show"),
//
//     posts: Em.Route.extend({
//       route: "/posts",
//
//       show: Em.Route.extend({
//         route: "/:post_id",
//         connectOutlets: function(router, context) {
//           router.get("applicationController").connectOutlet("body", "post", context);
//         }
//       }),
//
//       index: Em.Route.extend({
//         route: "/",
//         connectOutlets: function(router) {
//           var posts = Scvrush.get("store").findAll(Scvrush.Post);
//           router.get("applicationController").connectOutlet("body", "posts", posts);
//         }
//       })
//     }),
//
//     users: Em.Route.extend({
//       route: "/users",
//
//       index: Em.Route.extend({
//         route: "/",
//         connectOutlets: function(router) {
//           var users = Scvrush.get("store").findAll(Scvrush.User);
//           router.get("applicationController").connectOutlet("body", "users", users);
//         }
//       }),
//
//       show: Em.Route.extend({
//         route: "/:user_id",
//         connectOutlets: function(router, context) {
//           router.get("applicationController").connectOutlet("body", "user", context);
//         }
//       })
//
//     }),
//
//     tournaments: Em.Route.extend({
//       route: "/tournaments",
//
//       index: Em.Route.extend({
//         route: "/",
//         connectOutlets: function(router) {
//           var tournaments = Scvrush.get("store").findAll(Scvrush.TournamentDay);
//           router.get("applicationController").connectOutlet("body", "tournaments", tournaments);
//         }
//       }),
//
//       user: Em.Route.extend({
//         route: "/my_tournaments",
//         connectOutlets: function(router) {
//           var tournaments = Scvrush.get("store").find(Scvrush.TournamentDay, { user: true });
//           router.get("applicationController").connectOutlet("body", "tournaments", tournaments);
//         }
//       }),
//
//       show: Em.Route.extend({
//         route: "/:tournament_id",
//         connectOutlets: function(router, context) {
//           router.get("applicationController").connectOutlet("body", "tournament", context);
//         }
//       })
//
//     }),
//
//     index: Em.Route.extend({
//       route: "/",
//       connectOutlets: function(router) {
//         router.get("applicationController").connectOutlet("body", "home");
//       }
//     })
//
//   })
//
// });
