Scvrush.TournamentsIndexController = Ember.ArrayController.extend({

  query: null,

  sortProperties: ["id"],
  sortAscending: false,

  updateTournaments: _.debounce(function(value) {
    var tournaments;

    if (this.get("query") === "" || this.get("query.length") < 3) {
      tournaments = Scvrush.Tournament.find();
    } else {
      tournaments = Scvrush.Tournament.find({ query: this.get("query") });
    }

    this.set("content", tournaments);
  }, 200),

  queryChanged:function (value) {
    this.updateTournaments()
  }.observes("query")

});
