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
  events: {
    'click .delete': 'deleteComment',
    'click .reply': 'reply',
    'click .original': 'highlightOriginal'
  },
  template: _.template('<h4><%= author %>' +
    '<span class="date"><%= date %> ago</span>' +
    '<a class="delete">delete</a>' +
    '<a class="reply">reply</a>' +
    // link to display the original of the reply comment
    '<% if (typeof orig !== "undefined") print("<a class=\\"original\\">in reply to</a>") %>'+
    '</h4>' +
    '<%= content %>'),

  initialize: function() {
    this.model.on('destroy', function() { this.$el.remove(); }, this);
  },

  // Highlight the original comment that is being replied to.
  // It also makes all the other comments transparent.
  // TODO - add a simple way to remove the effect from all comments.
  // TODO - what should I do if the comment was deleted?
  highlightOriginal: function() {
    this.resetHighlight();

    var selector = '#comment-' + this.originalComment;
    $(selector).css('background', '#fafafa');
    $('.comment').not(selector).not(this.$el).animate({opacity: 0.5}, 'fast');
  },

  resetHighlight: function() {
    $('.comment').css({
      opacity: 1,
      background: 'none'
    });
  },

  render: function() {
    var attributes = this.model.toJSON();
    var match = attributes.content.match(/@(\d+) (.+)/);
    if (match) {
      attributes.reply  = true;
      attributes.orig = match[1];
      this.originalComment = attributes.orig;
    } else {
      attributes.reply = false;
    }
    var html = this.template(attributes);
    this.$el.html(html);
    return this;
  },

  deleteComment: function(e) {
    e.preventDefault();
    this.model.destroy();
  },

  reply: function() {
    this.trigger('reply', this);
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
    this.collection.forEach(this.addOne, this);
    return this;
  },

  // Render one comment into the comments list
  addOne: function(model) {
    var view = new App.CommentView({
      model: model,
      id: 'comment-' + model.id
    });
    view.on('reply', this.reply, this);
    this.$('.comments').append(view.render().el);
  },

  // Submit a comment to the server
  postComment: function(event) {
    event.preventDefault();
    var textarea = this.$textarea;

    if (textarea.val().length > 10) {
      this.collection.create({
        content: textarea.val(),
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

  // Handle enter being pressed in the textarea
  handleEnter: function(event) {
    if ((event.metaKey || event.ctrlKey) && event.keyCode == 13) {
      this.$('form').submit();
    }
    if (this.$textarea.val().length > 10) {
      this.$('fieldset').removeClass('error');
    }
  },

  reply: function(view) {
    console.log('reply triggered on a view', view);
    this.$textarea.focus();
    this.$textarea.val('@' + view.model.id + ' ');
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
  // window.f = new App.CommentsFormView();
  // window.f.render();
  window.r = new App.Router();

  $('input[name=foo]').autocomplete({
    source: ['foo', 'bar', 'baz']
  });

});