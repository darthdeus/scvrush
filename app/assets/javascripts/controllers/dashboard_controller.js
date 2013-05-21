Scvrush.DashboardController = Ember.ObjectController.extend({

  needs: "postsIndex",
  posts: null,

  init: function() {
    this._super();

    var self = this;

    Scvrush.Post.query({ query: "scene-news" }).then(function(result) {
      self.set("posts", result.slice(0, 3));
    });
  },

  upcomingTournaments: function() {
    return Scvrush.Tournament.query({ league: this.get("league") });
  }.property("league")


  // isTrialChanged: function() {
  //   if (this.get("isTrial")) {
  //     this.transitionToRoute("home");
  //   }
  // }.observes("isTrial")

});
