Scvrush.UserTimelineController = Ember.ObjectController.extend({

  init: function() {
    this._super();
    this.set("content", Scvrush.currentUser);
  },

  users: function() {
    return Scvrush.User.filter();
  }.property(),

  suggestedPosts: function() {
    return Scvrush.Post.query({ query: this.get("race"), limit: 3 });
  }.property("race"),

  suggestedCoaches: function() {
    return Scvrush.Post.query({ query: this.get("race") + " coach", limit: 3 });
  }.property("race"),

});
