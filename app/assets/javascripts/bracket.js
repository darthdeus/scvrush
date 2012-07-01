function BracketCtrl($scope) {
  $scope.rounds = [
    {
      type: "round",
      round: 8,
      number: 1,
      matches: [
        { player1: "ham", player2: "burger" },
        { player1: "jack", player2: "john" },
        { player1: "kara", player2: "tiara" },
        { player1: "tara", player2: "lara" }
      ]
    },

    {
      type: "round",
      round: 4,
      number: 2,
      matches: [
        { player1: "ham", player2: "jack" },
        { player1: "kara", player2: "lara" }
      ]
    },

    {
      type: "round",
      round: 2,
      number: 3,
      matches: [
        { player1: "ham", player2: "kara" }
      ]
    }
  ];

  $scope.clickPlayer = function(player) {
    debugger;
  };


}

jQuery(function($) {

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

  var dimensions = {
    playerHeight: 20,
    playerBox: 26,
    playerGap: 3,
    matchGap: 10,
    roundTop: 0
  };

  $('.bracket').applyDimensions(dimensions);

  $('.bracket .player').live({
    mouseenter: function() {
      var cls = $(this)[0].className;
      // TODO - add backwards compatible #map
      cls = cls.split(' ').map(function(n) { return "." + n; }).join("")
      $(cls).addClass('player-highlight');
    },

    mouseleave:function() {
      var cls = $(this)[0].className;
      // TODO - add backwards compatible #map
      cls = cls.split(' ').map(function(n) { return "." + n; }).join("")
      $(cls).removeClass('player-highlight');
    }

  });

});
