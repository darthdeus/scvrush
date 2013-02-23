Scvrush.UserLinkView = Ember.View.extend({
  tagName: "span",

  didInsertElement: function() {
    Scvrush.User.find({ username: this.get("username") });
    this.get("users");
  },

  user: null,
  users: function() {
    var self = this;

    return Scvrush.User.filter(function(user) {
      if (self.get("username") && user.get("username")) {
        return user.get("username").toLowerCase() === self.get("username").toLowerCase();
      } else {
        return false;
      }
    });
  }.property("username"),

  usersChanged: function() {
    var self = this;

    Ember.run.next(function() {
      self.set("user", self.get("users.lastObject"));
    });
  }.observes("users.length"),

  template: Ember.Handlebars.compile("{{#if view.user}}{{#linkTo 'user' view.user}}@{{view.user.username}}{{/linkTo}}{{else}}@{{view.username}}{{/if}}")
});

