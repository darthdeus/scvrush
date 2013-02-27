Scvrush.UserLinksView = Ember.View.extend({

  template: function() {
    var template = this.get("content");

    if (template) {
      template = template.replace(/@([\w\-_]+)/, "{{view Scvrush.UserLinkView username='$1'}}");
    }

    return Ember.Handlebars.compile(template || "");
  }.property("content"),

  contentChanged: function() {
    this.rerender();
  }.observes("content"),

});
