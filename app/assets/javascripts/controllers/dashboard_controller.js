Scvrush.DashboardController = Ember.ObjectController.extend({

  needs: "postsIndex",
  posts: null,

  init: function() {
    this._super();
    this.set("posts", Scvrush.Post.query());
  },

  gotoCoaches: function() {
    this.transitionToRoute("posts");
    this.set("controllers.postsIndex.query", Scvrush.currentUser.get("race") + " coach");
  }

});
