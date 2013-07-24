Scvrush.PostIndexRoute = Scvrush.Route.extend({

  model: function() {
    return this.modelFor("post");
  },

  setupController: function(controller, model) {
    controller.set("model", model);
    $("title").text(model.get("title"));
  },

  renderTemplate: function() {
    this.render();
    this.render("posts/related", {
      into: "application",
      outlet: "sidebar"
    });
  },

});
