Scvrush.UserProfileController = Ember.ObjectController.extend({

  users: function() {
    return Scvrush.User.filter();
  }.property(),

  allTournaments: function() {
    return Scvrush.Tournament.all()
  }.property(),

  upcomingTournaments: function() {
    return this.get("allTournaments").slice(0, 5);
  }.property("allTournaments.@each.id")

});
