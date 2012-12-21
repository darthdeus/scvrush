Scvrush.NewStatusView = Em.TextField.extend({

  insertNewline: function() {
    var text = this.get("value"),
        user = Scvrush.currentUser;

    Scvrush.Status.createRecord({ text: text, user: user, timeline: user });
    Scvrush.store.commit();

    this.set("value", "");
  }

});
