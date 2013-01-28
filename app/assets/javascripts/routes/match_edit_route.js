Scvrush.MatchEditRoute = Ember.Route.extend({
  setupController: function(controller, model) {
    controller.set("model", this.controllerFor("match").get("content"));
    controller.set("tournament", this.controllerFor("tournament").get("content"));
  }
});

