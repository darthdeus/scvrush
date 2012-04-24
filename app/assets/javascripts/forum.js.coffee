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

  template: ->
    _.template($('#new-topic-template').html(), {})

  show: ->
    $.fancybox
      # we need to warp this back in jQuery object to bind events
      content: $(@template())
      onComplete: @bindEvents

  bindEvents: ->
    @content.find('.cancel').click (e) ->
      e.preventDefault()
      $.fancybox.close()

    @content.find('button[type=submit]').click (e) ->
      e.preventDefault()
      console.log('form submitted')

class Reply extends Backbone.Model

class Replies extends Backbone.Collection
  model: Reply
  url: -> @topic.url() + '/replies'

  initialize: (options) ->
    @topic = options.topic


window.Section = Section
window.Sections = Sections
window.Topic = Topic
window.TopicView = TopicView
window.Topics = Topics
window.TopicFormView = TopicFormView
window.Reply = Reply
window.Replies = Replies

$ ->
  window.sf = new TopicFormView()
#  sf.show()
