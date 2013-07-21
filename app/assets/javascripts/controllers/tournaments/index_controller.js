Scvrush.TournamentsIndexController = Ember.ArrayController.extend({
  query: null,

  init: function() {
    this._super();
    this.updateTournaments();
  },

  sortProperties: ["startsAt"],
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

  groupedContent: function() {
    var groupedObject = _(this.get("content").toArray()).groupBy(function(tournament) {
      return tournament.get("startDay");
    });

    var results = [];

    for (key in groupedObject) {
      results.push({ date: key, tournaments: groupedObject[key] });
    }

    return results;

  }.property("content.[]"),

  queryChanged:function (value) {
    this.updateTournaments()
  }.observes("query")

});
