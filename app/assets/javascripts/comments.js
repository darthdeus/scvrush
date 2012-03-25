window.App = {}

App.Post = Backbone.Model.extend({
  urlRoot: '/posts'
});

App.Comment = Backbone.Model.extend({

});

App.CommentView = Backbone.View.extend({

  className: 'comment',

  template: _.template('<h4><%= author %>' +
    '<span class="date"><%= date %> ago</span></h4>' +
    '<%= content %>'),

  render: function() {
    var html = this.template(this.model.toJSON());
    this.$el.html(html);
    return this;
  }

});

App.Comments = Backbone.Collection.extend({

  model: App.Comment,

  url: function() {
    return this.post.url() + '/comments';
  },

  initialize: function(options) {
    this.post = options.post;
  },


});

App.CommentsView = Backbone.View.extend({

  el: '.comments',

  initialize: function() {
    this.collection.on('reset', this.render, this);
  },

  render: function() {
    this.$el.empty();
    this.collection.forEach(this.addOne, this);
  },

  addOne: function(model) {
    var view = new App.CommentView({model: model});
    this.$el.append(view.render().el);
  }
});

$(function() {
  $('.comments').empty();
  var post = new App.Post({id: $('.post').attr('data-post-id')});
  window.c = new App.Comments({post: post});
  window.c.fetch();
  window.v = new App.CommentsView({collection: window.c});
});