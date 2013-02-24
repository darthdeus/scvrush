Scvrush.ImageView = Ember.View.extend({
  tagName: "img",
  attributeBindings: ["src"],

  didInsertElement: function() {
    this.$()[0].onerror = function() {
      this.src = "https://s3.amazonaws.com/scvrush/uploads/post/featured_image/100x100_dark.png";
    };
  }

});
