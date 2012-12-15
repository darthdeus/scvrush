Scvrush.RoundsView = Em.View.extend({
  templateName: "rounds",

  didInsertElement: function() {
    Ember.run.later(function() {
      $(".bracket").applyDimensions(window.dimensions);
    }, 500);
  }
});
