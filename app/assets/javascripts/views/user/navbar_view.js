Scvrush.UserNavbarView = Ember.View.extend({

  didInsertElement: function() {
    var navbar = this.$(".user-navbar");

    $(window).scroll(function(event) {
      var scrollTop = $(window).scrollTop();

      if (scrollTop > 0 && scrollTop < 60) {
        navbar.css("top", 60 - scrollTop);
      } else if (scrollTop >= 60) {
        navbar.css("top", 0);
      } else {
        navbar.css("top", 60);
      }
    });
  }

});
