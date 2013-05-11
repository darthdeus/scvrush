Scvrush.UserEditController = Ember.ObjectController.extend({

  saved: false,

  contentChanged: function() {
    this.get("content").on("didUpdate", function() {
      // TODO - find a better way to avoid this race condition
      Ember.run.later(this, function() {
        this.set("saved", true);
      }, 500);

    }.bind(this));
  }.observes("content"),

  aboutChanged: function() {
    this.set("saved", false);
  }.observes("about"),

  submit: function() {
    this.get("content").save();
  }

});
