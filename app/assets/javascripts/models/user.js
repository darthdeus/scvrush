Scvrush.User = DS.Model.extend({
  username:  DS.attr("string"),
  race:      DS.attr("string"),
  image:     DS.attr("string"),
  bnet_info: DS.attr("string"),

  statuses:  DS.hasMany("Scvrush.Status"),
  followers: DS.hasMany("SCvrush.User"),

  hasFollowers: function() {
    if (this.get("followers")) {
      return this.get("followers.length") > 0;
    }
  },

  raceClass: function() {
    if (this.get("race")) {
      return "race-" + this.get("race").toLowerCase();
    }
  }.property("race")

});
