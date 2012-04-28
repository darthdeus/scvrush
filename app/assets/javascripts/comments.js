window.App = window.App || {};
var App = window.App;

App.postsPrefix = function() {
  if (this.post === undefined) {
    throw 'post is undefined in the app, unable to create a comments URL';
  }
  return '/posts/' + this.post;
};

App.Comment = Backbone.Model.extend({

  nesting: function() {
    var parent = this.get('parent_id'),
        nesting = 0,
        comment;

    if (typeof parent == "undefined") return nesting;

    while (comment = window.c.get(parent)) {
      nesting++;
      parent = comment.get('parent_id');
    }
    return nesting;
  }

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
    '<span class="meta">' +
    '<a class="delete">delete</a>' +
    '<a class="reply">reply</a>' +
    '</span>' +
    // TODO - make this link to the parent instesad of the user profile
    // TODO - add a cancel link here, so that a user can cancel the reply
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
    // We need to mark this comment as a response to indent it properly
    // TODO - views should be indented in multiple levels
    if (this.model.get('parent_id')) {
      this.$el.addClass('comment-response');
    }

    if ((typeof window.user_id == "undefined")
          || window.user_id != this.model.get('user_id')) {
      this.$('.delete').remove();
    }

    this.$el.addClass("comment-response-" + this.model.nesting());

    return this;
  },

  // TODO - add check or render only for the current_user
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
    return App.postsPrefix() + '/comments';
  },

  initialize: function() {
    this.on('reset', this.render, this);
    // this.on('add', this.fetch, this);
  },

});

App.CommentsView = Backbone.View.extend({
  el: '#comments',
  template: _.template($('#comments-template').html()),
  events: {
    'submit form': 'postComment',
    'keydown textarea': 'handleEnter',
    'click a.first-comment': 'focusForm',
    'click a.login-link': 'showLoginLayer'
  },

  initialize: function() {
    this.collection.on('reset', this.render, this);

    this.collection.on('add', function(model) {
      this.collection.fetch();
    }, this);

    this.collection.on('remove', this.toggleFirstComment, this);
  },

  toggleFirstComment: function() {
    if (this.collection.length == 0) {
      this.$el.find('a.first-comment').show();
    } else {
      this.$el.find('a.first-comment').hide();
    }
  },

  render: function() {
    this.$el.empty();
    this.$el.append(this.template());

    this.toggleFirstComment();

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
    var self = this;
    var textarea = this.$textarea;

    if (textarea.val().length > 10) {
      var attributes = {
        content: textarea.val(),
        post_id: App.post
      };

      var parent_id = this.$('[name="parent_id"]').val();
      if (typeof parent_id != 'undefined' && parent_id !== '') {
        attributes.parent_id = parent_id;
        console.log('parent_id was set to', parent_id);
      } else {
        console.log('parent_id was undefined', parent_id,
                     this.$('[name="parent_id"]').val());
      }

      this.collection.create({comment: attributes}, {
        wait: true,
        // TODO - not sure what happens to context here ...
        // is this still referencing to the view? Or is it
        // the ajax object?
        success: function() {
          self.resetForm();
          // TODO - this shouldn't be done here, but rather sort the items
          // before rendering them, and remove the sorting on the server
          // self.fetch();
        },
        error: function(comment, response) { console.log(comment, response); }
      });
    } else {
      this.$('fieldset').addClass('error');
    }
  },

  resetForm: function() { this.$textarea.val(''); },
  focusForm: function() { this.$textarea.focus() },

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
    this.focusForm();

    this.$('[name="parent_id"]').val(view.model.id);
    this.$('.reply-message').css('visibility', 'visible');

    var user_path = '/users/'
                    + view.model.get('user_id')
                    + '-'
                    + view.model.get('author');

    this.$('.reply-username').text(view.model.get('author'))
                            .attr('href', user_path);
  },

  showLoginLayer: function(e) {
    e.preventDefault();
    $('ul.nav .js-login-link').click();
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

  window.v = new App.CommentsView({collection: window.c}),
  window.r = new App.Router();

  $('.comments-wrap a.first-comment').click(function(e) {
    e.preventDefault();
    window.v.$textarea.focus();
  });

});