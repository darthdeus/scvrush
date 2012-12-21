Scvrush.User = DS.Model.extend({
  username: DS.attr("string"),
  race:     DS.attr("string"),

  raceClass: function() {
    return "race-" + this.get("race").toLowerCase();
  }.property("race")

});
