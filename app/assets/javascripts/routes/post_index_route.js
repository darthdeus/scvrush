Scvrush.PostIndexRoute = Scvrush.Route.extend({

  model: function() {
    return this.modelFor("post");
  },

  renderTemplate: function() {
    this.render();
    this.render("posts/related", {
      outlet: "sidebar"
    });
  }

});
