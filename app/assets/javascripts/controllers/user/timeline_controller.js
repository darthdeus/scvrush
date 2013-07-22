Scvrush.UserTimelineController = Ember.ObjectController.extend({

  init: function() {
    this._super();
    this.set("content", Scvrush.currentUser);
  },

  users: function() {
    return Scvrush.User.filter();
  }.property(),

  suggestedPosts: function() {
    if (this.get("race")) {
      return Scvrush.Post.query({ query: this.get("race"), limit: 3 });
    }
  }.property("race"),

  suggestedCoaches: function() {
    if (this.get("race")) {
      return Scvrush.Coach.query({ race: this.get("race"), limit: 3 });
    }
  }.property("race"),

});
