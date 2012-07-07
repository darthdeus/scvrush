//= require jquery
//= require jquery_ujs
//= require lib/jquery.fancybox
//= require lib/underscore
//= require lib/backbone
//= require lib/bootstrap
//= require lib/chosen
//= require dashboard
//= require dataTables/jquery.dataTables
//= require dataTables/jquery.dataTables.bootstrap
//= require login

jQuery(function($) {
  $('.chosen').chosen();

  $('input[type=text]:first').focus();

  $('.carousel').carousel({ interval: 3500 });

  if (!window.gon) {
    window.gon = {};
  }

  var url = "http://api.justin.tv/api/stream/list.json"
  $.ajax({
    url: url,
    dataType: "jsonp",
    data: { channel: "scvrush1" },
    jsonp: "jsonp",
    success: function(data) {
      $("li.stream a")
        .css('color', 'rgba(255, 150, 150, 0.8)')
        .text('Check out our Stream - LIVE NOW!');
      $('#inline-stream').show();
    }
  })

  $('#new_comment').submit(function(e) {
    var self = $(this),
        textarea = self.find('[data-required]');
    if (textarea.val() == '') {
      textarea.parent('fieldset').addClass('error');
      textarea.focus();
      self.find('.btn').button('reset');
      return false;
    } else {
      textarea.parent('fieldset').removeClass('error');
      return true;
    }
  });

  // TODO - refactor this
  if ($.fn.dialog) {
    $('#publish-date-form').dialog({
    autoOpen: false,
    modal: true,
    width: 300,
    height: 150
    });
  }

  $('.pick-race button').click(function(e) {
    $('#picked-race').val($(this).text());
  });

  $('.pick-server button').click(function(e) {
    $('#picked-server').val($(this).text());
  });


  $('.pick-league button').click(function(e) {
    $('#picked-league').val($(this).text());
  });


  $(".publish_link").click(function(e) {
    e.preventDefault();
    var dialog = $("#publish-date-form"),
        post_id = $(this).attr('data-post-id');

    if (!post_id) {
      alert("post_id is empty");
    }

    dialog.find('form').attr("action", "/posts/" +  post_id + "/publish");
    dialog.dialog("open");
  });

  if ($.fn.datepicker) {
    $(".datepicker").datepicker();
  }

  for (filter in ['race', 'league', 'server']) {
    if (gon[filter]) {
      $(".pick-#{filter} button").each(function() {
        if ($(this).text() == gon[filter]) {
          $(this).click();
        }
      });
    } else {
      $(".pick-#{filter} button:first").click();
    }
  }

});
