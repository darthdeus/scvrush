Scvrush.RoundsController = Em.ArrayController.extend({
  contentBinding: "Scvrush.router.tournamentController.rounds",
  view: null,

  hasRounds: function() {
    return this.get("content.length") > 0;
  }.property("@each.item"),

  seed: function(event) {
    Scvrush.store.createRecord(Scvrush.Bracket, { tournament: event.context });
    Scvrush.store.commit();
    // Ember.run.later(this, function() {
    //   event.context.reload();
    // }, 500);
  },

  unseed: function(event) {
    Scvrush.store.adapter.deleteRecord(Scvrush.store, Scvrush.Bracket, { id: event.context.id });
    // Ember.run.later(this, function() {
    //   event.context.reload();
    // }, 500);
  },

});
