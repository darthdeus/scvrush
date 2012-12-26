Scvrush.StatusesView = Em.CollectionView.extend({
  itemViewClass: Em.View.extend({

    template: function() {
      template = this.get("content.text");

      if (template) {
        template = template.replace(/@(\w+)/g, '{{view Scvrush.UserLinkView username="$1"}}');
      }

      return Ember.Handlebars.compile(template || "");
    }.property("content.text"),

    contentChanged: function() {
      Ember.run.next(this, function() {
        this.rerender();
      });
    }.observes("content.text"),

  })
});

Scvrush.UserLinkView = Ember.View.extend({
  tagName: "span",
  user: function() {
    return Scvrush.User.findByUsername(this.get("username"));
  }.property(),
  template: Ember.Handlebars.compile('<a {{action showUser view.user href=true}}>@{{view.username}}</a>')
});


// Scvrush.LinkedUsersView = Ember.View.extend({
//   template: function() {
//     template = this.get("content").replace(/@(\w+)/g, '{{view MyApp.UserLinkView username="$1"}}');
//     return Ember.Handlebars.compile(template);
//   }.property()
// });
