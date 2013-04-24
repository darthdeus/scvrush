Scvrush.TournamentEditRoute = Scvrush.Route.extend({

  activate: function() {
    var tournament = this.modelFor("tournament"),
        transaction = tournament.get("store").transaction();

    transaction.add(tournament);
  },

  deactivate: function() {
    this.modelFor("tournament").get("transaction").rollback();
  }

});
