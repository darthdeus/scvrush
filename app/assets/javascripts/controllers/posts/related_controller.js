Scvrush.PostsRelatedController = Ember.ArrayController.extend({

  init: function() {
    this._super();
    this.set("content", Scvrush.Post.all());
  }

});
