Scvrush.TournamentRoute = Scvrush.Route.extend({

  events: {
    adminToggle: function() {
      this.controllerFor("tournament").toggleProperty("adminView");
    }
  },

});
