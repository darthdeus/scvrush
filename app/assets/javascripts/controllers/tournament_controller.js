Scvrush.TournamentController = Em.ObjectController.extend({

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

  register: function() {
    debugger
    this.set("content.isRegistered", true);
    this.get("store").commit();
  },

  checkin: function() {
    this.set("content.isChecked", true);
    this.get("store").commit();
  },

  cancel: function() {
    this.set("content.isRegistered", false);
    this.set("content.isChecked", false);
    this.get("store").commit();
  },

  deleteTournament: function() {
    this.get("content").deleteRecord();
    this.get("store").commit();
  },

});
