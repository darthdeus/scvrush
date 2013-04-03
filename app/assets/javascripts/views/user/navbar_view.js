Scvrush.UserNavbarView = Ember.View.extend({

  didInsertElement: function() {
    var navbar = this.$(".user-navbar");

    $(window).scroll(function(event) {
      var scrollTop = $(window).scrollTop();

      if (scrollTop > 0 && scrollTop < 180) {
        navbar.css("top", 180 - scrollTop);
      } else if (scrollTop >= 180) {
        navbar.css("top", 0);
      } else {
        navbar.css("top", 180);
      }
    });
  }

});
