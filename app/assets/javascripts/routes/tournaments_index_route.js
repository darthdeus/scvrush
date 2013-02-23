Scvrush.TournamentsIndexRoute = Ember.Route.extend({
  model: function() {
    return Scvrush.Tournament.find();
  }
});
