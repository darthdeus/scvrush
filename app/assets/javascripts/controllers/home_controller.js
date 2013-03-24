Scvrush.HomeController = Ember.ObjectController.extend({

  init: function() {
    this._super();

    var controller = this;

    var response = Scvrush.Post.featuredPost();
    response.then(function() {
      controller.set("featuredPost", response.get("firstObject"));
    });
  },

  step2: function() {
    return !!this.get("race");
  }.property("race"),

  step3: function() {
    return !!this.get("server") && this.get("step2");
  }.property("server")

});
