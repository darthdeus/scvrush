class Section extends Backbone.Model

class SectionView extends Backbone.View

class Sections extends Backbone.Collection
  model: Section
  url: '/sections'

class SectionsView extends Backbone.View

class Topic extends Backbone.Model
  url: ->
    "/topics/#{@id}"

class TopicView extends Backbone.View
  template: _.template('<div class="topic"><a href="#">' +
            '<div class="date"><%= last_reply %></div>' +
            '<div class="name"><%= name %></div></a></div>')

  render: ->
    @template(name: @model.name, last_reply: @model.last_reply)

class Topics extends Backbone.Collection
  model: Topic
  url: -> @section.url() + '/topics'

  initialize: (options) ->
    @section = options.section


class TopicFormView extends Backbone.View

  template: -> _.template($('#new-topic-template').html())

  show: (section) ->
    html = @template()
    $.fancybox
      # we need to warp this back in jQuery object to bind events
      content: $(html({section: section}))
      onComplete: @bindEvents

  bindEvents: ->
    @content.find('.cancel').click (e) ->
      e.preventDefault()
      $.fancybox.close()

    @content.find('button[type=submit]').click (e) ->
      e.preventDefault()
      form = $(this).parents('form')
      section_id = form.find('input[name="topic[section_id]"]').val()
      $.ajax
        type: 'POST'
        url: "/sections/#{section_id}/topics"
        data: form.serialize()
        success: (data) ->
          document.location = data.location
        error: (data) ->
          # TODO - add login check if user is not authorized
          console.log('error response', data)

    @content.find('input[type=text]:first').focus()

class Reply extends Backbone.Model

class ReplyView extends Backbone.View
  className: 'reply'
  template: _.template('<div class="author">' +
    '<a href="/users/<%= user_id %>-<%= author %>"><%= author %></a>' +
    '<span class="date"><%= date %> ago</span></div>' +
    '<div class="content"><%= content %>')

  render: ->
    html = @template(@model.toJSON())
    @$el.html(html)
    return @


class Replies extends Backbone.Collection
  model: Reply
  url: -> @topic.url() + '/replies'

  initialize: (options) ->
    @topic = options.topic

class RepliesView extends Backbone.View
  el: '#replies'
  template: -> _.template($('#replies-template').html())
  events:
    'submit form': 'postReply'
    'keydown textarea': 'handleEnter'

  initialize: ->
    # We need to initialize the Replies collection with a Topic,
    topic_id = $(@el).attr('data-topic-id')
    # but there is no need for the topic to have any other attributes
    # than just an `id'
    @topic = new Topic({id: topic_id})
    @collection = new Replies({topic: @topic})
    @collection.on('reset', @render, @)
    @collection.on('add', @addOne, @)

  addOne: (model) ->
    view = new ReplyView({model: model})
    @$('.replies').append(view.render().el)

  render: ->
    @$el.empty()
    @$el.append(@template()())
    @$textarea = @$('textarea')
    @collection.forEach(@addOne, @)

  resetForm: ->
    @$textarea.val('')

  postReply: (e) ->
    self = @
    e.preventDefault()

    if @$textarea.val().length <= 10
      @$('fieldset').addClass('error')
    else
      attributes =
        content: @$textarea.val()
        topic_id: @topic.id
      window.a = attributes
      @collection.create({reply: attributes}, {
        wait: true
        success: ->
          self.resetForm()
        error: (reply, response) ->
          console.log(reply, response)
      })


  # Handle when a user presses Ctrl/Command + Enter in the <textarea>
  handleEnter: (event) ->
    if (event.metaKey || event.ctrlKey) && event.keyCode == 13
      @$('form').submit()
    if @$textarea.val().length > 10
      @$('fieldset').removeClass('error')


window.Section = Section
window.Sections = Sections
window.Topic = Topic
window.TopicView = TopicView
window.Topics = Topics
window.TopicFormView = TopicFormView
window.Reply = Reply
window.ReplyView = ReplyView
window.Replies = Replies
window.RepliesView = RepliesView

$ ->
  window.sf = new TopicFormView()

  $('.newtopic').click (e) ->
    e.preventDefault()
    if gon.user_id
      section_id = $(this).attr 'data-section-id'
      throw "section_id is a required attribute" unless section_id
      sf.show section_id
    else
#      $('ul.nav .js-login-link').click();
      # TODO - make a global login object singleton
      window.loginForm.show()

  window.r = new RepliesView()
  window.r.collection.fetch()
#  sf.show()
