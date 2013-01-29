Scvrush.LoginController = Ember.Controller.extend({

  login: function() {
    var controller = this;

    $.post("/sessions.json", {
      username: this.get("username"),
      password: this.get("password")
    }, function(data) {
      controller.get("store").load(Scvrush.User, data.user);
      Scvrush.set("currentUser", Scvrush.User.find(data.user.id));
    });
  }

});
