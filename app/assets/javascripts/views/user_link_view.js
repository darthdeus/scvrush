Scvrush.UserLinkView = Ember.View.extend({
  tagName: "span",

  didInsertElement: function() {
    this.get("users");
  },

  users: function() {
    var users = Scvrush.User.find({ username: this.get("username") }),
    // var users = Scvrush.User.findByUsername(this.get("username"));
        view = this;

    users.then(function(response) {
      view.set("user", response.get("firstObject"));
    });

    return users;
  }.property("username"),

  template: Ember.Handlebars.compile("{{#if view.user}}{{#linkTo 'user' view.user}}@{{view.user.username}}{{/linkTo}}{{else}}{{view.username}}{{/if}}")
});

