Scvrush.RaceSelectionView = Em.Select.extend({

  valueChanged: function() {
    var view = this;

    Ember.run.next(function() {
      view.get("controller.store").commit();
    });
  }.observes("value"),

  disabled: function() {
    return this.get("model.isSaving");
  }.property("model.isSaving"),

});
