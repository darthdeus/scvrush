Scvrush.LoadMoreView = Ember.View.extend({
  templateName: "load_more",

  didInsertElement: function() {
    var view = this;
    // this.$().bind("inview", function(event, isInView, visiblePartX, visiblePartY) {
    //   if (isInView) Ember.tryInvoke(view.get("controller"), "loadMore");
    // });
  }
});
