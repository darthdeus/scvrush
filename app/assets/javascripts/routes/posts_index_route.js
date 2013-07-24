Scvrush.PostsIndexRoute = Scvrush.Route.extend({

  model: function() {
    return Scvrush.Post.find();
  },

  setupController: function(controller, model) {
    controller.set("model", model);
    $("title").text("Posts");
  },

  activate: function() {
    Ember.run.next(this, function() {
      this.controllerFor("postsIndex").set("query", "");
    });
  },

  renderTemplate: function() {
    this.render();
    this.render("posts/timeline", {
      into: "application",
      outlet: "sidebar"
    });
  },


});
