Scvrush.Round = DS.Model.extend({
  number:     DS.attr("number"),
  humanName:  DS.attr("string"),
  mapPool:    DS.attr("string"),
  bo:         DS.attr("number"),

  tournament: DS.belongsTo("Scvrush.Tournament"),
  matches:    DS.hasMany("Scvrush.Match"),


  allMatches: function() {
    return this.get("matches");
  }.property("matches.@each.score"),

  matchesFor: function(user) {
    return this.get("matches").filter(function(match) {
      return match.hasPlayer(Scvrush.currentUser);
    });
  },

  numberClass: function() {
    return "round-" + this.get("number");
  }.property("number"),

});
