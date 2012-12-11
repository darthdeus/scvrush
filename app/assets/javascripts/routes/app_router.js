Scvrush.Router = Ember.Router.extend({
  location: 'hash',
  enableLogging: true,

  root: Em.Route.extend({
    gotoHome:    Em.Route.transitionTo("root.index"),
    gotoContent: Em.Route.transitionTo("root.content"),

    showCoach: Em.Route.transitionTo("root.show"),

    show: Em.Route.extend({
      route: "/coach/:id",
      serialize: function(router, context) { return { id: context.id }; },
      deserialize: function(router, context) { return Scvrush.Coach.find(context.id); },
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
          router.get("applicationController").connectOutlet("body", "coaches", Scvrush.Coach.all());
        }
    })
  })

});
