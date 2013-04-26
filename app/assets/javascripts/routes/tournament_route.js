Scvrush.TournamentRoute = Scvrush.Route.extend({

  setupController: function(controller, model) {
    // this.set("reloader", setInterval(function() {
    //   model.reload();
    // }, 10000));
  },

  deactivate: function() {
    // clearInterval(this.get("reloader"));
  },

  events: {
    adminToggle: function() {
      this.controllerFor("tournament").toggleProperty("adminView");
    }
  },

});
