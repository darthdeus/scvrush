Scvrush.TournamentSignupButton = Em.View.extend({
  templateName: "tournament_signup_button",

  tagName: "span",

  register: function(event) {
    event.context.set("is_registered", true);
    Scvrush.store.commit();
  },

  cancel: function(event) {
    event.context.set("is_registered", false);
    Scvrush.store.commit();
  }

});
