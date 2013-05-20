Scvrush.NavbarController = Ember.Controller.extend({
  gotoTournamentsTemp: function() {
    this.transitionToRoute("post", Scvrush.Post.find(9936));
  }
})
