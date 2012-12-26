Scvrush.RoundsController = Em.ArrayController.extend({
  contentBinding: "Scvrush.router.tournamentController.rounds",
  view: null,

  hasRounds: function() {
    return this.get("content.length") == 0;
  }.property("content"),

  seed: function(event) {
    Scvrush.store.createRecord(Scvrush.Bracket, { tournament: event.context });
    Scvrush.store.commit();
    Event.run.next(this, function() {
      event.context.reload();
    });
  },

  unseed: function(event) {
    Scvrush.store.adapter.deleteRecord(Scvrush.store, Scvrush.Bracket, { id: event.context.id });
    Event.run.next(this, function() {
      event.context.reload();
    });
  },

});
