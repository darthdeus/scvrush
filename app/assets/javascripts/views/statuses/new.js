Scvrush.NewStatusView = Em.TextField.extend({

  insertNewline: function(event) {
    event.preventDefault();

    var text = this.get("value"),
        user = Scvrush.currentUser;

    user.get("statuses").createRecord({ text: text, user: user, timeline: user });
    Scvrush.store.commit();

    this.set("value", "");

    return false;
  }

});
