Scvrush.MatchesController = Ember.ObjectController.extend({

  sortedMatches: function() {
    return this.get("doneMatches").sort(function(a, b) {
      return a.get("updatedAt") < b.get("updatedAt")
    });
  }.property("doneMatches.@each.updatedAt")

});
