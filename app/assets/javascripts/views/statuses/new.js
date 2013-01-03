Scvrush.NewStatusView = Em.TextField.extend({

  insertNewline: function(event) {
    event.preventDefault();
    this.createStatus();
    return false;
  },

  createStatus: function() {
    var text = this.get("value"),
        user = Scvrush.currentUser;

    user.get("statuses").createRecord({ text: text, user: user });

    Scvrush.store.commit();

    this.set("value", "");
  },

});

// Scvrush.NewStatusTextField = Em.TextField.extend({
//   insertNewline: function() {
//   }
// });
