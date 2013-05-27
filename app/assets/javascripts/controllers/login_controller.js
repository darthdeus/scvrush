Scvrush.LoginController = Ember.Controller.extend({

  username: "",
  password: "",
  loginFailed: false,

  login: function() {
    this.set("loginFailed", false);
    this._request();
  },

  _request: function() {
    Ember.$.ajax({
      url: "/api/sessions.json",
      method: "POST",

      context: this,
      data: {
        username: this.get("username"),
        password: this.get("password")
      },

      success: this._success,
      error: function() { this.set("loginFailed", true); }
    });
  },

  _success: function(data) {
    this.get("store").load(Scvrush.User, data.user);

    var user = Scvrush.User.find(data.user.id)

    Scvrush.currentUser.changeUser(user);
    this.transitionToRoute("user", user);
  }


});
