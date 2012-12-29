Scvrush.RoundsView = Em.View.extend({
  templateName: "rounds",

  roundsChanged: function() {
    this.rerender();
  }.observes("Scvrush.router.roundsController.content.length"),

  didInsertElement: function() {
    Ember.run.later(function() {
      $(".bracket").applyDimensions(window.dimensions);
    }, 500);
  },

//   willDestroyElement: function() {
//     console.log("willDestroyElement");
//   },
//
//   willInsertElement: function() {
//     console.log("willInsertElement");
//   },
//
//   willClearRender: function() {
//     console.log("view rerendered");
//   },

});
