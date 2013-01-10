Scvrush.Status = DS.Model.extend({
  text:     DS.attr("string"),
  user:     DS.belongsTo("Scvrush.User"),
  createdAt: DS.attr("date"),

  postDate: function() {
    return moment(this.get("createdAt")).fromNow();
  }.property("createdAt"),

});
