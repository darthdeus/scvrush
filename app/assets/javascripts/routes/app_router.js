Scvrush.Router = Ember.Router.extend({
  location: 'hash',
  enableLogging: true,

  root: Ember.Route.extend({
    index: Ember.Route.extend({
      route: "/",
      connectOutlets: function(router) {
        router.get("applicationController").connectOutlet("body", "home");
      }
    })
  }),

  content: Ember.Route.extend({
    index: Ember.Route.extend({
      route: "/content",
      connectOutlets: function(router) {
        router.get("applicationController").connectOutlet("body", "content");
      }
    })
  })
});

