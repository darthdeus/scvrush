Scvrush.HomeController = Ember.ObjectController.extend({

  step2: function() {
    return !!this.get("race");
  }.property("race"),

  step3: function() {
    return !!this.get("server") && this.get("step2");
  }.property("server")

});
