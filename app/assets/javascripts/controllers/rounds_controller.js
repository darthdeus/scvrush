Scvrush.RoundsController = Em.ArrayController.extend({
  contentBinding: "Scvrush.router.tournamentController.rounds",

  hasContent: function() {
    return this.get("content").toArray().length == 0;
  }.property("content"),

  seed: function(event) {
    Scvrush.store.createRecord(Scvrush.Bracket, { tournament: event.context });
    Scvrush.store.commit();
  },

  unseed: function(event) {
    Scvrush.store.adapter.deleteRecord(Scvrush.store, Scvrush.Bracket, { id: event.context.id });
    event.context.reload();
  },

});
