Scvrush.TournamentsUpcomingController = Ember.ArrayController.extend({

  init: function() {
    this._super();
    this.set("content", Scvrush.currentUser.upcomingTournaments());
  }

});
