Scvrush.MatchEditController = Ember.ObjectController.extend({

  saveMatch: function(match) {
    match.save();
    match.one("didUpdate", this, function() {
      Ember.run.next(this, function() {
        this.transitionToRoute("tournament", match.get("tournament"));
      });
    });
  }

});
