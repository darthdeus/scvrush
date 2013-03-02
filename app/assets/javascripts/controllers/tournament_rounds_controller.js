Scvrush.TournamentRoundsController = Ember.ObjectController.extend({

  adminEdit: function(match) {
    var controller = this.controllerFor("tournament");

    if (controller.get("isAdmin")) {
      this.transitionTo("match.edit", match);
    }
  },

  userIfPresent: function(user) {
    if (user) {
      this.transitionToRoute("user", user);
    }
  }

});
