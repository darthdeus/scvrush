Scvrush.UserActivateController = Ember.ObjectController.extend({

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
    var user = this.get("content");

    user.set("usernameTaken", false);
    user.set("emailTaken", false);

    $.ajax({
      url: "/users/validate",
      data: {
        username: user.get("username"),
        email: user.get("email")
      },
      context: this,
      success: this._saveUser,
      error: function(response) {
        Ember.run(function() {
          var data = JSON.parse(response.responseText);

          user.set("usernameTaken", !!data.username);
          user.set("emailTaken", !!data.email);
        });
      }
    });

  },

  expiresIn: function() {
    var time = moment(this.get("expiresAt"));
    if (time) {
      return time.calendar();
    }
  }.property("expiresAt"),

  _saveUser: function() {
    Ember.run(this, function() {
      var user = this.get("content");

      this.notifyPropertyChange("invalid");
      this.notifyPropertyChange("passwordInvalid");
      this.notifyPropertyChange("passwordConfirmationInvalid");

      if (this.get("invalid")) {
        return;
      }

      user.get("content").one("didUpdate", this, function() {
        alert("Your account was activated. Welcome to SCV Rush!");
        this.transitionToRoute("home");
      });

      user.get("transaction").commit();
    });
  }

});
