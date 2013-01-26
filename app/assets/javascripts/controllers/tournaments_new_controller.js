Scvrush.TournamentsNewController = Em.ObjectController.extend({

  addRound: function() {
    this.get("content").increaseRounds();
  },

});
