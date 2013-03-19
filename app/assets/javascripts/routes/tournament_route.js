Scvrush.TournamentRoute = Scvrush.Route.extend({

  setupController: function(controller, model) {
    // this.set("reloader", setInterval(function() {
    //   model.reload();
    // }, 10000));
  },

  deactivate: function() {
    // clearInterval(this.get("reloader"));
  }

});

Scvrush.TournamentIndexRoute = Scvrush.Route.extend({

  model: function() {
    return this.modelFor("tournament");
  }

});
