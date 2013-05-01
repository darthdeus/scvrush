Scvrush.Round = DS.Model.extend({
  number:     DS.attr("number"),
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

  displayText: function() {
    var number = this.get("number");
    switch (number) {
      case 1: return "Champion";
      case 2: return "Finals";
      case 4: return "Semifinals";
      case 8: return "Quarter Finals";
      default: return "Round of " + number;
    };
  }.property("number")


});
