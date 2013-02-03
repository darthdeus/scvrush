Scvrush.UserLinksView = Ember.View.extend({

  template: function() {
    var template = this.get("content");

    if (template) {
      template = template.replace(/@(\w+)/, '<a href="#/users/$1">@$1</a>');
    }

    return Ember.Handlebars.compile(template || "");
  }.property("content"),

  // contentChanged: function() {
  //   this.rerender();
  // }.observes("content"),

});
