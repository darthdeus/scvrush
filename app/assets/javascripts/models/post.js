var converter = new Markdown.Converter();

GOO = DS.Model.extend(Ember.Validations.Mixin);

Scvrush.Post = DS.Model.extend({
  title:   DS.attr("string"),
  content: DS.attr("string"),
  image:   DS.attr("string"),

  content_html: function() {
    return converter.makeHtml(this.get("content") || "");
  }.property("content")

});
