//= require jquery
//= require jquery_ujs
//= require jquery.ui.all
//= require ./vendor/manifest
//= require pnotify
//= require bootstrap

$(function() {
  Trackets.init({
    api_key: "fad2a363d5c034a49804f2c64ffe4856",
    api_base_url: "http://trackets.com"
  });

  var navbar = $(".user-navbar");

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

  $(".choice-picker span").click(function() {
    var self = $(this),
        race = self.data("value"),
        parent = self.parents(".choice-picker");

    parent.find("span").removeClass("active");
    self.addClass("active");

    parent.find("input[type=hidden]").val(race);
  });

  $(".datepicker").datetimepicker();
});
