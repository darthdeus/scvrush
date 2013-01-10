Scvrush.PostsController = Em.ArrayController.extend({
  query: null,

  updatePosts: _.debounce(function(value) {
    var posts;

    if (this.get("query") === "") {
      posts = Scvrush.get("store").find(Scvrush.Models.Post);
    } else {
      posts = Scvrush.get("store").find(Scvrush.Models.Post, { query: this.get("query") });
    }

    this.set("content", posts);
  }, 200),

  queryChanged:function (value) {
    this.updatePosts()
  }.observes("query")

});
