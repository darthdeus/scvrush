var converter = new Markdown.Converter();

Scvrush.Post = DS.Model.extend({
  title:   DS.attr("string"),
  content: DS.attr("string"),
  image:   DS.attr("string"),
  tagList: DS.attr("object"),

  contentHtml: function() {
    return converter.makeHtml(this.get("content") || "");
  }.property("content")

});

Scvrush.Post.reopenClass({

  featuredPost: function() {
    return Scvrush.Post.query();
  }

});
