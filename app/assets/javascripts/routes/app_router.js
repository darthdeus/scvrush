//= require_self
//= require_tree .

Scvrush.Router.map(function() {
  this.route("home", { path: "/" });
  this.route("meet_scvrush", { path: "/meet-scvrush" });
  this.route("contact", { path: "/contact" });

  this.resource("posts", { path: "/posts" }, function() {
    this.resource("post", { path: "/:post_id" }, function() {
    });
  });

  this.resource("tournaments", { path: "/tournaments" }, function() {
    this.route("new", { path: "/new" });

    this.resource("tournament", { path: "/:tournament_id" }, function() {
      this.route("edit", { path: "/edit" });

      this.resource("matches", { path: "/matches" }, function() {
        this.resource("match", { path: "/:match_id" }, function() {
          this.route("edit", { path: "/edit" });
        });
      });
    });
  });

  this.resource("notifications");

  this.resource("users", { path: "/users" }, function() {
    this.resource("user", { path: "/:user_id" }, function() {
      this.route("edit", { path: "/edit" });
      this.route("tournaments", { path: "/tournaments" });
      this.route("login", { path: "/login" });
      this.route("activate", { path: "/activate" });
    });
  });

});
