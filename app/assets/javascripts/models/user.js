Scvrush.User = DS.Model.extend({
  username: DS.attr("string"),
  signups:  DS.hasMany("Scvrush.Signup")
});
