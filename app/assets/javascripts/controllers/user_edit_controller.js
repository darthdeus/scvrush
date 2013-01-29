Scvrush.UserEditController = Ember.Controller.extend({

  needs: "user",

  user: function() {
    return this.get("controllers.user.content");
  }.property("controllers.user.content"),

  isSaving: function() {
    return this.get("controllers.user.isSaving");
  }.property("controllers.user.isSaving"),

  expiresIn: function() {
    return moment(this.get("controllers.user.expiresAt")).calendar();
  }.property("controllers.user.expiresAt"),

});
