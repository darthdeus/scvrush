//= require_self
//= require_tree .

Scvrush.Router.reopen({
  location: "history"
});

Scvrush.Router.map(function() {
  this.route("home", { path: "/" });
  this.route("meet_scvrush", { path: "/meet-scvrush" });
  this.route("login", { path: "/login" });
  this.route("dashboard");

  this.resource("posts", { path: "/posts" }, function() {
    this.resource("post", { path: "/:post_id" }, function() {
    });
  });

  this.resource("tournaments", { path: "/tournaments" }, function() {
    this.route("new", { path: "/new" });

    this.resource("tournament", { path: "/:tournament_id" }, function() {
      this.route("emails");
      this.route("edit", { path: "/edit" });
      this.resource("signups", { path: "/signups" });
      this.resource("checked_trial_players", { path: "/checked_trial_players" });

      this.resource("matches", { path: "/matches" });
      this.resource("match", { path: "/matches/:match_id" }, function() {
        this.route("edit", { path: "/edit" });
      });
    });
  });

  this.resource("coaches");
  this.resource("coach", { path: "/coaches/:coach_id" });

  this.resource("notifications");

  this.resource("users", { path: "/users" }, function() {
    this.resource("user", { path: "/:user_id" }, function() {
      this.route("edit", { path: "/edit" });
      this.route("tournaments", { path: "/tournaments" });
      this.route("achievements", { path: "/achievements" });
      this.route("activate", { path: "/activate" });
    });
  });

  this.route("contact");
  this.route("notFound", { path: "*:" });
});
