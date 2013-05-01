Scvrush.UserTimelineController = Ember.ObjectController.extend({

  init: function() {
    this._super();
    this.set("content", Scvrush.currentUser);
  },

  // currentUserChanged: function() {
  //   this.set("content", Scvrush.currentUser)
  // }.observes("Scvrush.currentUser"),

  users: function() {
    return Scvrush.User.filter();
  }.property()

});
