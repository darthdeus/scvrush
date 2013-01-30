Scvrush.TournamentSignupButtonController = Ember.ObjectController.extend({

  init: function() {
    var controller = this;

    Ember.run.next(function() {
      controller.set("user", Scvrush.currentUser);
    });

    this._super();
  },

});
