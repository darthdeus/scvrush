Scvrush.UserTimelineController = Ember.ObjectController.extend({

  init: function() {
    this._super();
    this.set("content", Scvrush.currentUser);
  }

});
