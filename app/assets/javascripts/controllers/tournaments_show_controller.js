Scvrush.TournamentsShowController = Em.ObjectController.extend({

  seed: function(event) {
    Scvrush.Bracket.createRecord({ tournament: event.context });
    this.get("store").commit();
  },

  unseed: function(event) {
    $.post("/brackets/" + event.context.id, { _method: "DELETE" }, function(data) {
      Scvrush.store.load(Scvrush.Tournament, data.tournament);
    });
  },

  foo: function() {
    console.log("from controller", this.get("store").toString());
  },

  isAdmin: function() {
    return this.get("content.user") == Scvrush.currentUser;
  }.property("content.user"),

  start: function() {
    this.get("content").startNow();
  },

});
