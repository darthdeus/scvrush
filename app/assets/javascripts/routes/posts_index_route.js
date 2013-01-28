Scvrush.PostsIndexRoute = Em.Route.extend({
  model: function() {
    return Scvrush.Post.find();
  }
});
