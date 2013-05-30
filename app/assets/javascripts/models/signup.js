Scvrush.Signup = DS.Model.extend({
  status: DS.attr("string"),

  user: DS.belongsTo("Scvrush.User"),
  tournament: DS.belongsTo("Scvrush.Tournament"),

  isChecked: function() {
    return this.get("status") === "checked";
  }.property("status"),

  isCanceled: function() {
    return this.get("status") === "canceled";
  }.property("status")

});
