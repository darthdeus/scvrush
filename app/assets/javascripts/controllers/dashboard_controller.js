Scvrush.DashboardController = Ember.ObjectController.extend({

  needs: "postsIndex",
  posts: null,

  init: function() {
    this._super();
    this.set("posts", Scvrush.Post.query());
  },

  gotoCoaches: function() {
    this.transitionToRoute("posts");

    var query = Scvrush.currentUser.get("race") +
          " " + Scvrush.currentUser.get("server") +
          " coach";

    this.set("controllers.postsIndex.query", query);
  },

  isTrialChanged: function() {
    if (this.get("isTrial")) {
      this.transitionToRoute("home");
    }
  }.observes("isTrial")

});
