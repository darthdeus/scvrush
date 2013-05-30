Scvrush.SignupsController = Ember.ObjectController.extend({

  query: "",
  users: null,

  queryChanged: function() {
    this.updateUsers();
  }.observes("query"),

  updateUsers: _.debounce(function() {
    this.set("users", Scvrush.User.query({ bnet_info: this.get("query") }));
  }, 300),

  checkin: function(signup) {
    signup.set("status", "checked");
    signup.save().then();
  },

  delete: function(signup) {
    signup.set("status", "canceled");
    signup.save();
  }

});
