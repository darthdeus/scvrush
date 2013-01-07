Scvrush.TournamentsNewController = Em.Controller.extend({

  createTournament: function(event) {
    this.get("content").on("didCreate", function() {
      debugger
    });

    Scvrush.store.commit();
  },

  addRound: function() {
    this.get("content").increaseRounds();
  },

});
