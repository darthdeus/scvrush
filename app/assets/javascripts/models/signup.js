Scvrush.Signup = DS.Model.extend({
  status: DS.attr("string"),

  user: DS.belongsTo("Scvrush.User"),
});
