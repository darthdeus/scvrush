Scvrush.PostIndexRoute = Ember.Route.extend({

  model: function() {
    return this.modelFor("post");
  },

  renderTemplate: function() {
    this.render();
    this.render("posts/list", {
      outlet: "sidebar"
    });
  }

});
