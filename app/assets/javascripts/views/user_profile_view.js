Scvrush.UserProfileView = Ember.View.extend({
  templateName: "user/profile"
});

Scvrush.TabView = Ember.View.extend({

  click: function(event) {
    this.set("parentView.activeTab", this);
  },

  isActive: function() {
    return this.get("parentView.activeTab") === this;
  }.property("parentView.activeTab")

});
