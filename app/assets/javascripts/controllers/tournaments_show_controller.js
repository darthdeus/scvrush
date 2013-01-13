Scvrush.TournamentsShowController = Em.ObjectController.extend({

  seed: function() {
    Scvrush.Bracket.createRecord({ tournament: this.get("content") });
    this.get("store").commit();
  },

  unseed: function(event) {
    var self = this;
    $.post("/brackets/" + this.get("content.id"), { _method: "DELETE" }, function(data) {
      self.get("store").load(Scvrush.Tournament, data.tournament);
    });
  },

  isAdmin: function() {
    return this.get("content.user") == Scvrush.currentUser;
  }.property("content.user"),

  start: function() {
    this.get("content").startNow();
  },

});
