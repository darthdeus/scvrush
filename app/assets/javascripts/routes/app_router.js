Scvrush.Router = Ember.Router.extend({
  location: 'hash',
  enableLogging: true,

  root: Em.Route.extend({
    gotoHome:  Em.Route.transitionTo("root.index"),
    gotoPosts: Em.Route.transitionTo("posts.index"),
    showPost:  Em.Route.transitionTo("posts.show"),

    index: Em.Route.extend({
      route: "/",
      connectOutlets: function(router) {
        router.get("applicationController").connectOutlet("body", "home");
      }
    }),

    posts: Em.Route.extend({
      index: Em.Route.extend({
        route: "/posts",
        connectOutlets: function(router) {
          var posts = Scvrush.get("store").findAll(Scvrush.Post);
          router.get("applicationController").connectOutlet("body", "posts", posts);
        }
      }),

      show: Em.Route.extend({
        route: "/posts/:post_id",
        connectOutlets: function(router, context) {
          router.get("applicationController").connectOutlet("body", "post", context);
        }
      })

    })
  })

});
