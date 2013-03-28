Scvrush.Notification = Scvrush.Model.extend({
  text:   DS.attr("string"),
  unread: DS.attr("boolean"),
  user:   DS.belongsTo("Scvrush.User")
});
