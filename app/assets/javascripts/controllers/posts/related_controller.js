Scvrush.PostsRelatedController = Ember.Controller.extend({

  needs: "postIndex",
  postsBinding: "controllers.postIndex.relatedPosts"

});
