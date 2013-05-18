Scvrush.DashboardController = Ember.ObjectController.extend({

  needs: "postsIndex",
  posts: null,

  init: function() {
    this._super();
    this.set("posts", Scvrush.Post.query());
  },

  // isTrialChanged: function() {
  //   if (this.get("isTrial")) {
  //     this.transitionToRoute("home");
  //   }
  // }.observes("isTrial")

});
