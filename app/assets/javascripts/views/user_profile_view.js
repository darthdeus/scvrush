Scvrush.UserProfileView = Ember.View.extend({
  templateName: "user/profile",

  didInsertElement: function() {
    this.$().accordion({ header: "header" })
  }

});
