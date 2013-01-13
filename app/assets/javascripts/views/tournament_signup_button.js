Scvrush.TournamentSignupButton = Em.View.extend({
  templateName: "tournament_signup_button",

  tagName: "span",

  register: function(model) {
    model.set("isRegistered", true);
    this.get("controller.store").commit();
  },

  cancel: function(model) {
    model.set("isRegistered", false);
    this.get("controller.store").commit();
  }

});
