Scvrush.PostIndexController = Ember.ObjectController.extend({

  needs: "postsIndex",

  gotoCoaches: function() {
    this.transitionToRoute("posts");

    var query = Scvrush.currentUser.get("race") +
      " " + Scvrush.currentUser.get("server") +
      " coach";

    this.set("controllers.postsIndex.query", query);
  }

});
