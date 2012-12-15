Scvrush.Router = Ember.Router.extend({
  location: 'hash',
  enableLogging: true,

  root: Em.Route.extend({
    gotoHome:  Em.Route.transitionTo("root.index"),
    gotoUsers: Em.Route.transitionTo("users.index"),

    gotoPosts: Em.Route.transitionTo("posts.index"),
    showPost:  Em.Route.transitionTo("posts.show"),

    gotoTournaments: Em.Route.transitionTo("tournaments.index"),
    gotoUserTournaments: Em.Route.transitionTo("tournaments.user"),
    showTournament: Em.Route.transitionTo("tournaments.show"),

    posts: Em.Route.extend({
      route: "/posts",

      show: Em.Route.extend({
        route: "/:post_id",
        connectOutlets: function(router, context) {
          router.get("applicationController").connectOutlet("body", "post", context);
        }
      }),

      index: Em.Route.extend({
        route: "/",
        connectOutlets: function(router) {
          var posts = Scvrush.get("store").findAll(Scvrush.Post);
          router.get("applicationController").connectOutlet("body", "posts", posts);
        }
      })
    }),

    users: Em.Route.extend({
      route: "/users",

      index: Em.Route.extend({
        route: "/",
        connectOutlets: function(router) {
          var users = Scvrush.get("store").findAll(Scvrush.User);
          router.get("applicationController").connectOutlet("body", "users", users);
        }
      })
    }),

    tournaments: Em.Route.extend({
      route: "/tournaments",

      index: Em.Route.extend({
        route: "/",
        connectOutlets: function(router) {
          var tournaments = Scvrush.get("store").findAll(Scvrush.TournamentDay);
          router.get("applicationController").connectOutlet("body", "tournaments", tournaments);
        }
      }),

      user: Em.Route.extend({
        route: "/my_tournaments",
        connectOutlets: function(router) {
          var tournaments = Scvrush.get("store").find(Scvrush.TournamentDay, { user: true });
          router.get("applicationController").connectOutlet("body", "tournaments", tournaments);
        }
      })
    }),

    index: Em.Route.extend({
      route: "/",
      connectOutlets: function(router) {
        router.get("applicationController").connectOutlet("body", "home");
      }
    })

  })

});
