Scvrush.TagController = Ember.ObjectController.extend({

  needs: "postsIndex",

  filterTag: function(tag) {
    this.set("controllers.postsIndex.query", tag);
  }

});
