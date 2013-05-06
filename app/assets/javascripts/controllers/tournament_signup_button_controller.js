Scvrush.TournamentSignupButtonController = Ember.ObjectController.extend({

  user: null,

  init: function() {
    this._super();
    this.set("user", Scvrush.currentUser);
  },

  register: function(tournament, user) {
    tournament.set("isRegistered", true);
    tournament.get("transaction").commit();
  },

  checkin: function(tournament) {
    if (Scvrush.currentUser.get("isTournamentReady")) {
      tournament.set("isChecked", true);
      tournament.get("transaction").commit();
    }
  },

  cancel: function(tournament) {
    tournament.set("isRegistered", false);
    tournament.set("isChecked", false);
    tournament.get("transaction").commit();
  }

});
