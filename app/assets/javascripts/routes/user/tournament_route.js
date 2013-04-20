Scvrush.UserTournamentsRoute = Ember.Route.extend({

  setupController: function(controller) {
    var model = this.modelFor("user").get("playingTournaments");
    controller.set("model", model);
  }

})
