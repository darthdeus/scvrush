Scvrush.ShortTextView = Ember.View.extend({

  attributeBindings: ["title", "dataToggle:data-toggle"],
  titleBinding: "text",
  dataToggle: "tooltip",
  shortened: false,

  template: Ember.Handlebars.compile("{{view.shortenedText}}"),

  shortenedText: function() {
    var text = this.get("text");
    if (!text) return "";

    var shorter = text.slice(0, this.get("max"));

    if (shorter.length < text.length) {
      this.set("shortened", true);
      return shorter + "...";
    } else {
      return shorter;
    }
  }.property("text", "max"),

  didInsertElement: function() {
    if (this.get("shortened")) {
      this.$().tooltip({ placement: "right" });
    }
  }

});
