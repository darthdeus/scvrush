Scvrush.Coach = DS.Model.extend({
  name: DS.attr("string"),
  about: DS.attr("string"),

  races: DS.attr("object"),
  servers: DS.attr("object"),
  languages: DS.attr("object"),

  primaryServer: function() {
    return this.get("servers.firstObject");
  }.property("servers.[]"),

  primaryServerIcon: function() {
    return "/assets/coaches_" + this.get("primaryServer") + ".png";
  }.property("primaryServer"),

  raceIcon: function(race) {
    if (race) {
      return "/assets/race_" + race.toLowerCase() + "_icon.png";
    } else {
      return "/assets/race_random_icon.png";
    }
  },

  raceIcons: function() {
    var self = this;

    return this.get("races").map(function(race) {
      return self.raceIcon(race);
    });
  }.property("races.@each"),

  languageFlags: function() {
    return this.get("languages").map(function(language) {
      return "/assets/flags/" + language + ".png";
    });
  }.property("languages.@each"),

})
