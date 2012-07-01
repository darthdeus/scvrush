Scvrush.Router = Ember.Router.extend({

  // enableLogging: true,

  root: Ember.Route.extend({
    index: Ember.Route.extend({
      route: '/',

      // You'll likely want to connect a view here.
      connectOutlets: function(router) {

        router.get('applicationController').connectOutlet('tournament');

        // router.get('applicationController').connectOutlet({
        //   viewClass: Scvrush.MatchesView,
        //   controller: window.c = Scvrush.MatchesController.create(),
        //   context: [1,2,3]
        // });

        //"matches", [1,2,3]);
      }

      // Layout your routes here...
    })
  })
});
