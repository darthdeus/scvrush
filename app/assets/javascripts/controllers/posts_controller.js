Scvrush.PostsIndexController = Ember.ArrayController.extend({

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
    this.set("currentPage", 0);
    this.updatePosts()
  }.observes("query"),

  currentPage: 0,

  canLoadMore: function() {
    // can we load more entries? In this example only 10 pages are possible to fetch ...
    return this.get('currentPage') < 20;
  }.property('currentPage'),

  loadMore: function() {
    if (this.get('canLoadMore')) {
      this.set('isLoading', true);
      var page = this.incrementProperty('currentPage');

      // findQuery triggers somehing like /events?page=6 and this
      // will load more models of type App.Event into the store
      Scvrush.Post.find({ page: page });
    } else {
      this.set('isLoading', false);
    }
  }

});
