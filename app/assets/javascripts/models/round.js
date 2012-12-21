Scvrush.Round = DS.Model.extend({
  number: DS.attr("number"),
  matches: DS.hasMany("Scvrush.Match")
});
