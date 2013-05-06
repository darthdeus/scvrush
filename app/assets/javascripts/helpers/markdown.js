var showdown = new Markdown.Converter();

Ember.Handlebars.registerBoundHelper("markdown", function(input) {
  if (input) {
    return new Ember.Handlebars.SafeString(showdown.makeHtml(input));
  } else {
    return "";
  }
});
