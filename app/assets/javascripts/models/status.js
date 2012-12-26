Scvrush.Status = DS.Model.extend({
  text:     DS.attr("string"),
  user:     DS.belongsTo("Scvrush.User"),
  createdAt: DS.attr("date"),

  postDate: function() {
    return moment(this.get("createdAt")).fromNow();
  }.property("createdAt"),

  interpolatedText: function() {
    if (this.get("text")) {
      text = this.get("text").replace(/@\w+/g, '<a {{action showUser "$1" href="true"}}>$1</a>');
      return Ember.Handlebars.compile(text);
    }
  }.property("text"),

});
