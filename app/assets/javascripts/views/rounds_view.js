Scvrush.TournamentRoundsView = Em.View.extend({
  templateName: "rounds",

  roundsChanged: function() {
    this.rerender();
  }.observes("controller.rounds.length"),

  didInsertElement: function() {
    Ember.run.later(function() {
      $(".bracket").applyDimensions(window.dimensions);
    }, 500);
  }

});
