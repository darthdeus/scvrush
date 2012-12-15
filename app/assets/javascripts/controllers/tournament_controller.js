Scvrush.TournamentController = Em.ObjectController.extend({

  rounds: function() {
    var tournament_id = this.get("content.id");

    if (tournament_id) {
      return Scvrush.get("store").find(Scvrush.Round, { tournament_id: tournament_id });
    } else {
      return [];
    }
  }.property("content")

});
