Scvrush.CheckedTrialPlayersController = Ember.ObjectController.extend({

  checkedPlayers: function() {
    var self = this;
    $.get("/api/tournaments/" + this.get("id") + "/checked_trial_players.json", function(data) {
      Ember.run(function() {
        self.set("checkedPlayers", data.players);
      });
    });
  }.property("content.id")

});
