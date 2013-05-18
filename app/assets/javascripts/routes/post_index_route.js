Scvrush.PostIndexRoute = Scvrush.Route.extend({

  model: function() {
    return this.modelFor("post");
  },

  renderTemplate: function() {
    console.log("rendering outlet");
    this.render();
    this.render("posts/related", {
      into: "application",
      outlet: "sidebar"
    });
  }

});
