Scvrush.TournamentRoundsView = Em.View.extend({
  templateName: "rounds",

  roundsChanged: function() {
    this.rerender();
  }.observes("content.rounds.length"),

  didInsertElement: function() {
    Ember.run.later(function() {
      $(".bracket").applyDimensions(window.dimensions);
    }, 1000);
  }

});
