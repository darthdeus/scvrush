Scvrush.PostsIndexRoute = Em.Route.extend({

  model: function() {
    return Scvrush.Post.all();
  },

  renderTemplate: function() {
    this.render();
    this.render("user/timeline", {
      outlet: "sidebar"
    });
  }

});
