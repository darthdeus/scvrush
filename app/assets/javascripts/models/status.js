Scvrush.Status = DS.Model.extend({
  text:     DS.attr("string"),
  createdAt: DS.attr("date", { readonly: true }),
  user:     DS.belongsTo("Scvrush.User"),

  postDate: function() {
    return moment(this.get("createdAt")).utc().fromNow();
  }.property("createdAt")
});
