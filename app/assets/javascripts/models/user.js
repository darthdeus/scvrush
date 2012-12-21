Scvrush.User = DS.Model.extend({
  username: DS.attr("string"),
  race:     DS.attr("string"),
  image:    DS.attr("string"),

  raceClass: function() {
    if (this.get("race")) {
      return "race-" + this.get("race").toLowerCase();
    }
  }.property("race")

});
