Scvrush.UserLinkView = Ember.View.extend({
  tagName: "span",

  users: function() {
    // return Scvrush.store.find(Scvrush.User, { username: this.get("username") });
    return Scvrush.currentUser;
  }.property(),

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

