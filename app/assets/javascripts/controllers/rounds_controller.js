Scvrush.RoundsController = Em.ArrayController.extend({
  contentBinding: "Scvrush.router.tournamentController.rounds",

  hasContent: function() {
    return this.get("content").toArray().length != 0;
  }.property("content")
});
