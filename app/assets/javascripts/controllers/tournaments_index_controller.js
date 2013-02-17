Scvrush.TournamentsIndexController = Ember.ArrayController.extend({

  weeks: [
    { days: [ 1, 2, 3, 4, 5, 6, 7 ] },
    { days: [ 8, 9, 10, 11, 12, 13, 14 ] },
    { days: [ 15, 16, 17, 18, 19, 20, 21 ] },
    { days: [ 22, 23, 24, 25, 26, 27, 28 ] },
    { days: [ 29, 30, 31 ] },
  ],

  filter: function(event) {
    var day = event.context;
  },

});
