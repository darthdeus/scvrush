Scvrush.PostsIndexRoute = Scvrush.Route.extend({

  model: function() {
    return Scvrush.Post.find();
  },

  activate: function() {
    Ember.run.next(this, function() {
      this.controllerFor("postsIndex").set("query", "");
    });
  }

});
