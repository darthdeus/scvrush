Scvrush.TournamentSignupButtonController = Ember.ObjectController.extend({

  init: function() {
    this._super();

    Ember.run.next(this, function() {
      this.set("user", Scvrush.currentUser);
    });
  },

});
