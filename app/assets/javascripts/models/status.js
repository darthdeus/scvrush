Scvrush.Status = DS.Model.extend({
  text:     DS.attr("string"),
  user:     DS.belongsTo("Scvrush.User"),
  timeline: DS.belongsTo("Scvrush.User")
});
