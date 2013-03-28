Scvrush.NotificationsRoute = Ember.Route.extend({

  setupController: function(controller) {
    // TODO - look into why this has to be in setupController and not model hook
    controller.set("content", Scvrush.currentUser.get("notifications"));
  }

});
