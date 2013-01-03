Scvrush.NewStatusView = Em.TextField.extend({

  insertNewline: function(event) {
    event.preventDefault();
    this.createStatus();
    return false;
  },

  submitStatus: function(event) {
    event.preventDefault();
    this.createStatus();
    return false;
  },

  createStatus: function() {
    var text = this.get("value"),
        user = Scvrush.currentUser;

    var newStatus = user.get("statuses").createRecord({ text: text, user: user });
    this.set("isSaving", true);

    var self = this;

    newStatus.on("didCreate", function() {
      self.set("isSaving", false);
    });

    Scvrush.store.commit();

    this.set("value", "");
  },

});

// Scvrush.NewStatusTextField = Em.TextField.extend({
//   insertNewline: function() {
//   }
// });
