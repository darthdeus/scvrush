Scvrush.TournamentsUserController = Ember.ObjectController.extend({

  tournaments: function() {
    return Scvrush.Tournament.filter(function(tournament) {
      return tournament.get("isRegistered");
    });
  }.property("content")

});

