Scvrush.StatusesNewController = Ember.Controller.extend({

  createStatus: function() {
    var transaction = this.get("store").transaction(),
        text = this.get("text"),
        user = Scvrush.currentUser;

    // TODO - forbid empty strings such as " "
    if (Ember.isEmpty(text)) {
      return;
    }

    transaction.add(user);

    user.get("statuses").createRecord({ text: text, user: user });

    transaction.commit();

    this.set("text", "");
  },
});
