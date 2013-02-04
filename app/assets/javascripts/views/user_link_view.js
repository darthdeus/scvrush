Scvrush.UserLinkView = Ember.View.extend({
  tagName: "span",

  users: function() {
    var users = Scvrush.User.find({ username: this.get("username") });

    // users.one("didLoad", function() {
    //   users.resolve(users.get("firstObject"));
    // });

    return users;
  }.property("username"),

  user: function() {
    return this.get("users.firstObject") || Scvrush.currentUser;
  }.property("users.@each.length"),

  usersChanged: function() {
    Em.run.next(this, function() {
      this.rerender();
    });
  }.observes("users.@each"),

  usernameChanged: function() {
    console.log("username = ", this.get("username"));
  }.property("username"),

  // template: Ember.Handlebars.compile("{{#linkTo 'user' user}}@{{username}}{{/linkTo}}")
  template: Ember.Handlebars.compile("{{user}}")
});

