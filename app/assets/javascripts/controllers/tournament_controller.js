Scvrush.TournamentController = Em.ObjectController.extend({

  // rounds: function() {
  //   if (id = this.get("content.id")) {
  //     return Scvrush.get("store").find(Scvrush.Round, { tournament_id: id });
  //   } else {
  //     return [];
  //   }
  // }.property("content"),

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
    event.context.deleteRecord();
    // Scvrush.store.adapter.deleteRecord(Scvrush.store, Scvrush.Bracket, { id: event.context.id });
    // Ember.run.later(this, function() {
    //   event.context.reload();
    // }, 500);
  },

});
