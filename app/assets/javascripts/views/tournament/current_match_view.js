Scvrush.TournamentCurrentMatchView = Em.View.extend({
  templateName: "tournament/current_match",

  recommendedCoach: function() {
    return Scvrush.Coach.find({ race: Scvrush.currentUser.get("race"), limit: 1 });
  }.property("Scvrush.currentUser.race")
});
