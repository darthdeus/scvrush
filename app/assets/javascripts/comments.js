window.App = {
  urlPrefix: function() {
    if (this.post === undefined) {
      throw 'post is undefined in the app, unable to create a comments URL';
    }
    return '/posts/' + this.post;
  }
};

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
    return App.urlPrefix() + '/comments';
  }
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

// Form for submitting a new comment
App.CommentsFormView = Backbone.View.extend({
  el: '.new-comment',
  template: _.template($('#new-comment-template').html()),

  events: {
    'submit form': 'postComment',
    'keydown textarea': 'handleEnter'
  },

  render: function() {
    var html = this.template();
    this.$el.html(html);
    this.$textarea = this.$('textarea');
    return this;
  },

  postComment: function(event) {
    event.preventDefault();
    var content = this.$('textarea').val();
    var post_id = this.$('[name=post_id]').val();
    var comment = new App.Comment({content: content, post_id: post_id});
    if (content.length > 10) {
      comment.url = '/posts/' + post_id + '/comments';
      console.log('new comment submitted', comment);
      comment.save();
    } else {
      this.$('fieldset').addClass('error');
    }
  },

  handleEnter: function(event) {
    if ((event.metaKey || event.ctrlKey) && event.keyCode == 13) {
      this.$('form').submit();
    }
    if (this.$textarea.val().length > 10) {
      this.$('fieldset').removeClass('error');
    }
  }


});

App.Router = Backbone.Router.extend({
  routes: { 'comments': 'index' },

  initialize: function() {
    Backbone.history.start();
  },

  index: function() {
    $('.new-comment textarea').focus();
    console.log('we are on index');
  }

});


$(function() {
  $('.comments').empty();
  App.post = $('.post').attr('data-post-id');

  window.c = new App.Comments();
  window.c.fetch();
  window.v = new App.CommentsView({collection: window.c});
  window.f = new App.CommentsFormView();
  window.f.render();
  window.r = new App.Router();
});