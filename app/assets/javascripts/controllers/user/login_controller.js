Scvrush.UserLoginController = Ember.Controller.extend({

  login: function() {
    var store = this.get("store");

    $.post("/sessions.json", {
      username: this.get("username"),
      password: this.get("password")
    }, function(data) {
      store.load(Scvrush.User, data.user);
      Scvrush.set("currentUser", Scvrush.User.find(data.user.id));
    });
  }

});
