Scvrush.TournamentService = Ember.Object.extend();
Scvrush.TournamentService.reopenClass({

  realoadMatches: function(tournament) {
    tournament.reload();

    var promise = $.get("/matches?tournament_id=" + tournament.get("id"));

    promise.then(function(data) {
      tournament.get("store").loadMany(Scvrush.Match, data.matches);
    });

    return promise;
  }

});
