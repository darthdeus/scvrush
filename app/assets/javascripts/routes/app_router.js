Scvrush.Router = Ember.Router.extend({
  location: 'hash',
  enableLogging: true,

  root: Em.Route.extend({
    gotoHome:    Em.Route.transitionTo("root.index"),
    gotoContent: Em.Route.transitionTo("root.content"),

    showPost: Em.Route.transitionTo("root.show"),

    show: Em.Route.extend({
      route: "/post/:post_id",

      // serialize: function(router, context) {
      //   return { id: context.get("id") };
      // },

      // deserialize: function(router, context) {
      //   return Scvrush.get("store").find(Scvrush.Post, context.id);
      // },

      connectOutlets: function(router, context) {
        router.get("applicationController").connectOutlet("body", "post", context);
      }
    }),

    index: Em.Route.extend({
      route: "/",
      connectOutlets: function(router) {
        router.get("applicationController").connectOutlet("body", "home");
      }
    }),

    content: Em.Route.extend({
        route: "/content",
        connectOutlets: function(router) {
          var posts = Scvrush.get("store").findAll(Scvrush.Post);
          router.get("applicationController").connectOutlet("body", "posts", posts);
        }
    })
  })

});
