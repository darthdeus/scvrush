Scvrush.PostsIndexRoute = Scvrush.Route.extend({

  model: function() {
    return Scvrush.Post.find();
  },

});
