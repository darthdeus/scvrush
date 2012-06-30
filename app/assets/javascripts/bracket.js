//= require scvrush

jQuery(function($) {

  var bracket = $('#js-bracket');

  var dimensions = {
    playerHeight: 20,
    playerBox: 26,
    playerGap: 3,
    matchGap: 10,
    roundTop: 0
  };

  var players = 4,
      matches = players / 2;


  var recalculateDimensions = function(dim) {
    return {
      playerHeight: dim.playerHeight,
      playerBox: dim.playerBox,
      playerGap: dim.playerGap + dim.playerBox + dim.matchGap + 4,
      matchGap: dim.playerBox + dim.matchGap + dim.playerGap,
      roundTop: (dim.playerBox / 2) + (dim.playerGap / 2) + dim.roundTop
    };
  }

  var html = {
      round : function(dim) {
        return $('<div class="round">').css('marginTop', dim.roundTop);
      },
      match:  function(dim) {
        return $('<div class="match">').css('marginBottom', dim.matchGap);
      },
      player: function(dim) {
        return $('<div class="player">Player</div>')
               .css('height', dim.playerHeight);
      }
  };

  var scaffoldMatch = function(dim) {
    var p1 = html.player(dim);
    p1.css('marginBottom', dim.playerGap);
    return html.match(dim).append(p1).append(html.player(dim));
  };

  var roundOf = function(dim, num) {
    var round, match, marginTop, newDim;
    round = html.round(dim);

    // create matches
    for (var i = 0; i < num / 2; i++) {
      match = scaffoldMatch(dim);
      round.append(match);
    }

    bracket.append(round);
    return recalculateDimensions(dim);
  };


  var dim = dimensions;

  dim = roundOf(dim, 128);
  dim = roundOf(dim, 64);
  dim = roundOf(dim, 32);
  dim = roundOf(dim, 16);
  dim = roundOf(dim, 8);
  dim = roundOf(dim, 4);
  roundOf(dim, 2);

});
