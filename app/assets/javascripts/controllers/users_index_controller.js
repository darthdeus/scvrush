Scvrush.UsersIndexController = Ember.ArrayController.extend({

  query: "",
  isSearching: false,

  updateUsers: function() {
    var posts, self = this;

    this.set("isSearching", true);

    if (this.get("query") === "" && this.get("query.length") < 2) {
      posts = Scvrush.User.find();
    } else {
      posts = Scvrush.User.find({ query: this.get("query") });
    }

    posts.then(function() {
      self.set("isSearching", false);
    });

    this.set("content", posts);
  },

  filter: function(query) {
    this.set("query", this.get("query") + " " + query);
  },

  search: function() {
    this.updateUsers();
  }

});
