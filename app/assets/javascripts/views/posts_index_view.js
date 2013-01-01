Scvrush.PostsIndexView = Ember.View.extend({
  templateName: "posts/index",

  tag: function(event) {
    $(event.target).data("tag");
  }
});
