Scvrush.TournamentsUpcomingController = Ember.ArrayController.extend({

  init: function() {
    this._super();
    // Scvrush.Tournament.find();
    this.set("content", Scvrush.Tournament.all());
  }

});
