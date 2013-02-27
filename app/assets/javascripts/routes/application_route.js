Scvrush.ApplicationRoute = Ember.Route.extend({

  setupController: function() {
    Scvrush.currentUser.addObserver("statuses.length", this, "userLoaded");
  },

  userLoaded: function() {
    var user = Scvrush.currentUser;
    if (user.get("isTrial") && user.get("statuses.length") === 0) {

      this.sayHi();

    }
  },

  sayHi: function() {
    var user = Scvrush.currentUser;
    setTimeout(function() {
      var record = user.get("statuses").createRecord({ text: "" }),
          text = "Welcome to SCV Rush, post your first status here yo!",
          counter = 0;

      var interval = setInterval(function() {
        record.set("text", record.get("text") + text[counter]);
        counter++;

        if (counter == text.length) {
          clearInterval(interval);
        }

      }, 60);

    }, 1000);
  }

});
