Scvrush.TournamentsIndexRoute = Scvrush.Route.extend({

  model: function() {
    return Scvrush.Tournament.find();
  }

});
