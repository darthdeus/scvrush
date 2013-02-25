Scvrush.TournamentSignupButtonController = Ember.ObjectController.extend({

  user: null,

  init: function() {
    this._super();

    Ember.run.next(this, function() {
      this.set("user", Scvrush.currentUser);
    });
  },

});
