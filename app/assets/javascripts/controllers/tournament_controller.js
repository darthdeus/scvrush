Scvrush.TournamentController = Em.ObjectController.extend({

  register: function(tournament, t) {
    this.get("content").set("is_registered", true);
    Scvrush.store.commit();
  },

  cancel: function(tournament, t) {
    this.get("content").set("is_registered", false);
    Scvrush.store.commit();
  },

  seed: function(event) {
    Scvrush.store.createRecord(Scvrush.Bracket, { tournament: event.context });
    Scvrush.store.commit();
    // Ember.run.later(this, function() {
    //   event.context.reload();
    // }, 500);
  },

  unseed: function(event) {
    $.post("/brackets/" + event.context.id, { _method: "DELETE" }, function(data) {
      Scvrush.store.load(Scvrush.Tournament, data.tournament);
    });
  },

});
