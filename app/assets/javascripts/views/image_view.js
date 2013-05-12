Scvrush.ImageView = Ember.View.extend({
  tagName: "img",
  attributeBindings: ["src"],

  failed: false,

  didInsertElement: function() {
    var self = this;

    this.$().one("error", function() {
      self.set("failed", true);
      this.src = "https://s3.amazonaws.com/scvrush/uploads/post/featured_image/100x100_dark.png";
    });
  },

  willDestroyElement: function() {
    this.$().off("error");
  }

});
