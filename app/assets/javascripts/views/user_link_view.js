Scvrush.UserLinkView = Ember.View.extend({
  tagName: "span",

  didInsertElement: function() {
    Scvrush.User.checkUsername(this.get("username"));
  },

  user: function() {
    return this.get("controller.users").findProperty("username", this.get("username"));
  }.property("controller.users.@each.username"),

  template: Ember.Handlebars.compile("{{#if view.user}}{{#linkTo 'user' view.user}}@{{view.user.username}}{{/linkTo}}{{else}}@{{view.username}}{{/if}}")
});

