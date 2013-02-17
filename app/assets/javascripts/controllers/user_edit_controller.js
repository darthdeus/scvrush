Scvrush.UserEditController = Ember.ObjectController.extend({

  passwordInvalid: function() {
    return this.get("password.length") < 1;
  }.property("password"),

  passwordConfirmationInvalid: function() {
    return this.get("passwordConfirmation") !== this.get("password") || this.get("passwordInvalid");
  }.property("password", "passwordConfirmation"),

  invalid: function() {
    return this.get("passwordInvalid") || this.get("passwordConfirmationInvalid");
  }.property("passwordInvalid", "passwordConfirmationInvalid"),

  saveProfile: function() {
    var user = this.get("content"),
        controller = this;

    this.notifyPropertyChange("invalid");
    this.notifyPropertyChange("passwordInvalid");
    this.notifyPropertyChange("passwordConfirmationInvalid");

    if (this.get("invalid")) {
      return;
    }

    user.one("didUpdate", function() {
      alert("Your account was activated. Welcome to SCV Rush!");
      controller.transitionToRoute("home");
    });

    user.get("transaction").commit();
  },

  expiresIn: function() {
    var time = moment(this.get("expiresAt"));
    if (time) {
      return time.calendar();
    }
  }.property("expiresAt"),

});
