Scvrush.Signup = DS.Model.extend({
  user: DS.belongsTo("Scvrush.User"),
  tournament: DS.belongsTo("Scvrush.Tournament")
});
