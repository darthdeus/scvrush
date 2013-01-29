Scvrush.UserEditController = Ember.Controller.extend({

  needs: "user",

  user: function() {
    return this.get("controllers.user.content");
  }.property("controllers.user.content"),

  isSaving: function() {
    return this.get("controllers.user.isSaving");
  }.property("controllers.user.isSaving"),

  expiresIn: function() {
    var time = moment(this.get("controllers.user.expiresAt"));
    if (time) {
      return time.calendar();
    }
  }.property("controllers.user.expiresAt"),

});
