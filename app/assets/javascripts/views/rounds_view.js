Scvrush.RoundsView = Em.View.extend({
  templateName: "rounds",

  roundsChanged: function() {
    this.rerender();
  }.observes("tournament.rounds.length"),

  didInsertElement: function() {
    Ember.run.later(function() {
      $(".bracket").applyDimensions(window.dimensions);
    }, 500);
  }

});
