jQuery(function($) {
  window.dimensions = {
    playerHeight: 20,
    playerBox: 26,
    playerGap: 3,
    matchGap: 10,
    roundTop: 0
  };

  $.fn.applyDimensions = function(dim) {
    var recalculateDimensions = function(dim) {
      return {
        playerHeight: dim.playerHeight,
        playerBox: dim.playerBox,
        playerGap: dim.playerGap + dim.playerBox + dim.matchGap + 4,
        matchGap: dim.playerBox + dim.matchGap + dim.playerGap,
        roundTop: (dim.playerBox / 2) + (dim.playerGap / 2) + dim.roundTop
      };
    };

    $(this).find('.round').each(function(round) {
      $(this).css('marginTop', dim.roundTop);

      $(this).find('.player').css('height', dim.playerHeight);
      var matches = $(this).find('.match');
      matches.css('marginBottom', dim.matchGap);

      matches.find('.player:first').css('marginBottom', dim.playerGap);
      dim = recalculateDimensions(dim);
    });
  }

  if (gon && gon.highlight_id) {
    $(".player_#{gon.highlight_id}").effect("highlight", {}, 5000)
  }

  // TODO - change this to not account the dot in the bnet_info,
  // since it will break CSS selectors
  $('.bracket .player').live({
    mouseenter: function() {
      var cls = $(this)[0].className;
      cls = cls.split(' ').map(function(n) { return "." + n; }).join("")
      if (cls !== ".player.player_") {
        $(cls).addClass('player-highlight');
      }
    },

    mouseleave:function() {
      var cls = $(this)[0].className;
      cls = cls.split(' ').map(function(n) { return "." + n; }).join("")
      $(cls).removeClass('player-highlight');
    }

  });

});
