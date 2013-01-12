Scvrush.TournamentsNewController = Em.Controller.extend({

  addRound: function() {
    this.get("content").increaseRounds();
  },

});
