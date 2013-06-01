Scvrush.TournamentEditController = Ember.ObjectController.extend({

  notSavable: function() {
    return !this.get("isDirty") || this.get("isSaving");
  }.property("isSaving", "isDirty"),

  save: function() {
    var tournament = this.get("model");

    tournament.one("didUpdate", this, function() {
      Ember.run.next(this, function() {
        this.transitionToRoute("tournament", tournament);
      });
    });

    tournament.get("transaction").commit();
  }

});
