Scvrush.UsersIndexController = Ember.ArrayController.extend({

  query: null,

  updateUsers: _.debounce(function(value) {
    var posts;

    if (this.get("query") === "" && this.get("query.length") < 2) {
      posts = Scvrush.User.find();
    } else {
      posts = Scvrush.User.find({ query: this.get("query") });
    }

    this.set("content", posts);
  }, 200),

  queryChanged:function (value) {
    this.updateUsers()
  }.observes("query")

});
