Scvrush = Ember.Application.create({
  LOG_TRANSITIONS: true,
  rootElement: "#ember-app",
  ready: function() {
    var userId = this.$(this.rootElement).data("user-id");
    Scvrush.currentUser = Scvrush.User.find(userId);

    var bindKeys = function(event) {
      Scvrush.set("keyboard.shiftKey", event.shiftKey);
      Scvrush.set("keyboard.altKey", event.altKey);
      Scvrush.set("keyboard.ctrlKey", event.ctrlKey);
    };

    $(document).keydown(bindKeys);
    $(document).keyup(bindKeys);
  }
});

Scvrush.keyboard = Ember.Object.create();

window.c = Ember.c = function(name) {
  return Scvrush.__container__.lookup("controller:" + name);
}

Ember.Handlebars.registerBoundHelper("index", function(item, collection) {
  return collection.indexOf(item);
});
