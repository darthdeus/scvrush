Scvrush.UserAchievementsRoute = Ember.Route.extend({

  model: function() {
    return this.modelFor("user").get("achievements");
  }

})
