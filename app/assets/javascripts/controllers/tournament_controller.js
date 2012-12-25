Scvrush.TournamentController = Em.ObjectController.extend({

  // rounds: function() {
  //   if (id = this.get("content.id")) {
  //     return Scvrush.get("store").find(Scvrush.Round, { tournament_id: id });
  //   } else {
  //     return [];
  //   }
  // }.property("content"),

  register: function(tournament, t) {
    this.get("content").set("is_registered", true);
    Scvrush.store.commit();
  },

  cancel: function(tournament, t) {
    this.get("content").set("is_registered", false);
    Scvrush.store.commit();
  }

});
