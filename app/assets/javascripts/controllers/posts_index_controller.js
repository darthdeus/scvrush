Scvrush.PostsIndexController = Ember.ArrayController.extend({

  results: null,
  isLoading: false,
  query: "",

  search: function() {
    this.set("isLoading", true);
    this.loadMore()
  },

  loadMore: function() {
    var params = {
      page: this.incrementProperty("page"),
      query: this.get("query")
    };

    var results = Scvrush.Post.query(params);
    this.set("content", results);

    results.then(function() {
      this.set("isLoading", false);
    }.bind(this));
  }

});
