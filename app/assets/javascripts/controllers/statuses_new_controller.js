Scvrush.StatusesNewController = Ember.Controller.extend({

  createStatus: function() {
    var transaction = this.get("store").transaction(),
        text = this.get("text"),
        user = Scvrush.currentUser.get("content");

    if (Ember.isEmpty(text) || /^\W+$/.test(text)) {
      return;
    }

    transaction.add(user);
    user.get("statuses").createRecord({ text: text, user: user });
    transaction.commit();

    this.set("text", "");
  },

});
