Scvrush.Status = DS.Model.extend({
  text:     DS.attr("string"),
  user:     DS.belongsTo("Scvrush.User"),
  timeline: DS.belongsTo("Scvrush.User"),

//   didCreate: function(record) {
//     this.get("user.statuses").pushObject(this);
//     Scvrush.store.commit();
//   }
});
