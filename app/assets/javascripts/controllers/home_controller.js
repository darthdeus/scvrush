Scvrush.HomeController = Ember.ObjectController.extend({

  featuredPost: null,
  featuredTournament: null,

  init: function() {
    this._super();

    var controller = this;

    var response = Scvrush.Post.featuredPost();
    response.then(function() {
      controller.set("featuredPost", response.get("firstObject"));
    });

    var tournaments = Scvrush.Tournament.featuredTournament();
    tournaments.then(function() {
      controller.set("featuredTournament", tournaments.get("firstObject"));
    });
  },

  step2: function() {
    return !!this.get("race");
  }.property("race"),

  step3: function() {
    return !!this.get("server") && this.get("step2");
  }.property("server"),

  isTrialChanged: function() {
    console.log("redirecting");

    if (this.get("isTrial") === false) {
      Ember.run.next(this, function() {
        this.transitionToRoute("dashboard");
      });
    }
  }.observes("isTrial")

});
