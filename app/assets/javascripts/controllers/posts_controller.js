Scvrush.PostsIndexController = Em.ArrayController.extend({

  query: null,

  updatePosts: _.debounce(function(value) {
    var posts;

    if (this.get("query") === "") {
      posts = Scvrush.Post.find();
    } else {
      posts = Scvrush.Post.find({ query: this.get("query") });
    }

    this.set("content", posts);
  }, 200),

  queryChanged:function (value) {
    this.updatePosts()
  }.observes("query")

});
