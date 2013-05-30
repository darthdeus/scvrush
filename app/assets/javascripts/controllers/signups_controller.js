Scvrush.SignupsController = Ember.ObjectController.extend({

  query: "",
  users: null,

  queryChanged: function() {
    this.updateUsers();
  }.observes("query"),

  updateUsers: _.debounce(function() {
    var self = this,
        tournament = this.get("model");

    if (Ember.isEmpty(this.get("query"))) return;

    Scvrush.User.query({ bnet_info: this.get("query") }).then(function(results) {
      var filter = results.filter(function(user) {
        return !tournament.get("signups").mapProperty("user").contains(user);
      });

      self.set("users", filter);
    });
  }, 300),

  reload: function() {
    this.get("model").reload();
    this.updateUsers();
  },

  checkin: function(signup) {
    signup.set("status", "checked");
    signup.get("transaction").commit();
  },

  cancel: function(signup) {
    if (confirm("Are you sure?")) {
      signup.deleteRecord();
      signup.one("didDelete", this, "reload");
      signup.get("transaction").commit();
    }
  },

  register: function(user) {
    var self = this;

    var signup = Scvrush.Signup.createRecord({
      user: user,
      tournament: this.get("model")
    });

    signup.one("didCreate", this, "reload");
    signup.get("transaction").commit();
  },
});
