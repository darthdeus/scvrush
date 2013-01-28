//= require_self
//= require_tree .

Scvrush.Router.map(function() {
  this.route("home", { path: "/" });

  this.resource("posts", { path: "/posts" }, function() {
    this.route("post", { path: "/:post_id" });
  });

  this.resource("tournaments", { path: "/tournaments" }, function() {
    this.route("new", { path: "/new" });

    this.resource("tournament", { path: "/:tournament_id" }, function() {
      this.resource("matches", { path: "/matches" }, function() {
        this.resource("match", { path: "/:match_id" }, function() {
          this.route("edit", { path: "/edit" });
        });
      });
    });
  });

  this.resource("users", { path: "/users" }, function() {
    this.route("user", { path: "/:user_id" });
  });

});

Scvrush.MatchEditController = Ember.ObjectController.extend();
