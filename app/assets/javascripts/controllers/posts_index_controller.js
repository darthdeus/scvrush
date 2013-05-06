Scvrush.PostsIndexController = Ember.ArrayController.extend({

  content: function() {
    this.loadMore();
    return Ember.A();
  }.property(),

  query: null,
  queryChanged: function() {
    this.set("page", 0);
    this.updatePosts()
  }.observes("query"),

  updatePosts: _.debounce(function(value) {
    this.set("content", Ember.A());
    this.loadMore();
  }, 200),

  page: 0,
  isLoading: false,

  loadMore: function() {
    var params = {
      page: this.incrementProperty("page"),
      query: this.get("query")
    };

    var results = Scvrush.Post.find(params);
    results.one("didLoad", this, "load");
    this.set("results", results);
  },

  load: function() {
    this.get("results").forEach(function(result) {
      if (result) {
        this.pushObject(result);
      } else {
        throw "undefined";
      }
    }, this);
  }

});
