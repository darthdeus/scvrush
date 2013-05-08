Scvrush.LoginController = Ember.Controller.extend({

  login: function() {
    var store = this.get("store");
    var controller = this;

    $.post("/sessions.json", {
      username: this.get("username"),
      password: this.get("password")
    }, function(data) {
      store.load(Scvrush.User, data.user);

      var user = Scvrush.User.find(data.user.id)

      Scvrush.currentUser.changeUser(user);
      controller.transitionToRoute("user", user);
    });
  }

});
