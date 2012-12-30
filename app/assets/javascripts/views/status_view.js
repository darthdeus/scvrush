Scvrush.UserLinksView = Ember.View.extend({

  template: function() {
    template = this.get("content");

    if (template) {
      template = template.replace(/@(\w+)/g, '{{view Scvrush.UserLinkView username="$1"}}');
    }

    return Ember.Handlebars.compile(template || "");
  }.property("content"),

  contentChanged: function() {
    Ember.run.next(this, function() {
      this.rerender();
    });
  }.observes("content"),

});

Scvrush.UserLinkView = Ember.View.extend({
  tagName: "span",

  users: function() {
    return Scvrush.store.find(Scvrush.User, { username: this.get("username") });
  }.property("username"),

  usersChanged: function() {
    this.rerender();
  }.observes("users.@each"),

  user: function() {
    return this.get("users.firstObject");
  }.property("users.@each"),

  template: Ember.Handlebars.compile('<a {{action showUser view.user href=true}}>@{{view.username}}</a>')
});


// App.UserController = Ember.ObjectController.extend({
//   _content: null,
// 
//   content: function(key, value) {
//     var content = this.get('_content');
//     if (arguments.length === 2) {
//       content = Ember.makeArray(value);
//       this.set('_content', content);
//     }
//     return Ember.get(content, 'firstObject');
//   }.property('_content.firstObject')
// });
// 
// // both will work
// App.UserController.set('content', App.User.find(1));
// App.UserController.set('content', App.User.find({username: 'toto'}));
// 


// Scvrush.LinkedUsersView = Ember.View.extend({
//   template: function() {
//     template = this.get("content").replace(/@(\w+)/g, '{{view MyApp.UserLinkView username="$1"}}');
//     return Ember.Handlebars.compile(template);
//   }.property()
// });
