var converter = new Markdown.Converter();

Scvrush.Models.Post = DS.Model.extend({
  title:   DS.attr("string"),
  content: DS.attr("string"),
  image:   DS.attr("string"),

  content_html: function() {
    return converter.makeHtml(this.get("content") || "");
  }.property("content")

});
