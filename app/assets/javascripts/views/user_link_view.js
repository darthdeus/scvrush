Scvrush.UserLinkView = Ember.View.extend({
  tagName: "span",

  didInsertElement: function() {
    Scvrush.User.findByUsername(this.get("username"));
    this.get("users");
  },

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

  user: function() {
    return this.get("users.lastObject");
  }.property("users.lastObject"),

  template: Ember.Handlebars.compile("{{#if view.user}}{{#linkTo 'user' view.user}}@{{view.user.username}}{{/linkTo}}{{else}}@{{view.username}}{{/if}}")
});

