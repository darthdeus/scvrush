Scvrush.DashboardController = Ember.ObjectController.extend({

  posts: null,

  init: function() {
    this._super();
    this.set("posts", Scvrush.Post.query());
  }

});
