Scvrush.Bracket = Ember.Object.extend();

Scvrush.Bracket.reopenClass({

  seed: function(tournament) {
    $.post("/brackets/" + tournament.get("id"), { _method: "PUT" }, function(data) {
      Ember.run(function() {
        tournament.get("store").load(Scvrush.Tournament, data.tournament);
      });
    });
  },

  unseed: function(tournament) {
    $.post("/brackets/" + tournament.get("id"), { _method: "DELETE" }, function(data) {
      Ember.run(function() {
        tournament.get("store").load(Scvrush.Tournament, data.tournament);
      });
    });
  }

});
