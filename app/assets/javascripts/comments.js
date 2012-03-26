window.App = {
  urlPrefix: function() {
    if (this.post === undefined) {
      throw 'post is undefined in the app, unable to create a comments URL';
    }
    return '/posts/' + this.post;
  }
};

App.Comment = Backbone.Model.extend({
  // urlRoot: function() {
  //   return App.urlPrefix() + '/comments';
  // }
});

App.CommentView = Backbone.View.extend({
  className: 'comment',
  events: { 'click .delete': 'deleteComment' },
  template: _.template('<h4><%= author %>' +
    '<span class="date"><%= date %> ago</span><a class="delete">delete</a></h4>' +
    '<%= content %>'),

  initialize: function() {
    this.model.on('destroy', function() { this.$el.remove(); }, this);
  },

  render: function() {
    var html = this.template(this.model.toJSON());
    this.$el.html(html);
    return this;
  },

  deleteComment: function(e) {
    e.preventDefault();
    this.model.destroy();
  }

});

App.Comments = Backbone.Collection.extend({
  model: App.Comment,
  url: function() {
    return App.urlPrefix() + '/comments';
  }
});

App.CommentsView = Backbone.View.extend({
  el: '#comments',
  template: _.template($('#comment-template').html()),
  events: {
    'submit form': 'postComment',
    'keydown textarea': 'handleEnter'
  },

  initialize: function() {
    this.collection.on('reset', this.render, this);
    this.collection.on('add', this.render, this);
  },

  render: function() {
    this.$el.empty();
    this.$el.append(this.template());
    this.$textarea = this.$('textarea');
    console.log('textarea is', this.$textarea);
    this.collection.forEach(this.addOne, this);
    return this;
  },

  addOne: function(model) {
    var view = new App.CommentView({model: model});
    this.$('.comments').append(view.render().el);
  },

  postComment: function(event) {
    event.preventDefault();
    var textarea = this.$('textarea');
    var content = textarea.val();

    if (content.length > 10) {
      this.collection.create({
        content: content,
        post_id: App.post
      }, {
        wait: true,
        success: function() { textarea.val(''); },
        error: function(comment, response) { console.log(comment, response); }
      });
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

// Form for submitting a new comment
App.CommentsFormView = Backbone.View.extend({
  el: '.new-comment',



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
  // window.f = new App.CommentsFormView();
  // window.f.render();
  window.r = new App.Router();
});