Scvrush.PostsView = Ember.View.extend({
  templateName: 'posts',
  tag: function(event) {
    $(event.target).data("tag");
  }
});
