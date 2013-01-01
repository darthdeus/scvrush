Scvrush.UserLinksView = Ember.View.extend({

  template: function() {
    var template = this.get("content");

    if (template) {
      // template = template.replace(/@(\w+)/, '{{view Scvrush.UserLinkView username="$1"}}');
    }

    return Ember.Handlebars.compile(template || "");
  }.property("content"),

});

Scvrush.UserLinkView = Ember.View.extend({
  tagName: "span",

  // users: function() {
  //   return Scvrush.store.find(Scvrush.User, { username: this.get("username") });
  // }.property(),

  user: function() {
    // return this.get("users.firstObject");
    return Scvrush.currentUser;
  }.property(),

  // usersChanged: function() {
  //   Em.run.next(this, function() {
  //     this.rerender();
  //   });
  // }.observes("users.@each"),

  template: Ember.Handlebars.compile('<a {{action showUser view.user href=true}}>@{{view.username}}</a>')
});

