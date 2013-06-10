Scvrush.UserServerPickerController = Ember.ObjectController.extend({

  isEU: function() {
    return this.get("server") == "EU";
  }.property("server"),

  isNA: function() {
    return this.get("server") == "NA";
  }.property("server"),

  isKR: function() {
    return this.get("server") == "KR";
  }.property("server"),

  isSEA: function() {
    return this.get("server") == "SEA";
  }.property("server"),

  selectServer: function(server) {
    if (!this.get("isSaving")) {
      this.set("server", server);
      this.get("transaction").commit()
    }
  }

});

