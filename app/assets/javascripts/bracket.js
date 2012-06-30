jQuery(function($) {

  var bracket = $('#js-bracket');


  var dimensions = {
    playerHeight: 20,
    playerBox: 26,
    playerGap: 3,
    matchGap: 10,
    rondTop: 0
  };

  var players = 4,
      matches = players / 2;


  var recalculateDimensions = function(dim) {
    var newDim = {
        playerHeight: dim.playerHeight,
        playerBox: dim.playerBox,
        playerGap: dim.playerGap + 1.5 * dim.playerBox,
        roundTop: dim.playerBox / 2 + dim.playerGap / 2
    };
  }

  var html = {
      round : function(dim) { return $('<div class="round">').css('marginTop', dimensions.roundTop); },
      match:  function(dim) { return $('<div class="match">'); },
      player: function(dim) {
        return $('<div class="player">Player</div>')
               .css('height', dimensions.playerHeight);
      }
  };

  var scaffoldMatch = function() {
    return html.match().append(html.player()).append(html.player());
  };

  var roundOf = function(first, num) {
    var round, match, marginTop;

    if (first) {
      round = html.round();

      // create matches
      for (var i = 0; i < num / 2; i++) {
        match = scaffoldMatch();
        match.find('.player:first').css('marginBottom', dimensions.playerGap);
        round.append(match);
      }
    } else {
      round = html.round();

      marginTop =  dimensions.playerBox / 2 + dimensions.playerGap / 2;
      round.css('marginTop', marginTop);

      // create matches
      for (var i = 0; i < num / 2; i++) {
        match = scaffoldMatch();

        match.css('marginBottom', dimensions.playerBox + dimensions.matchGap + dimensions.playerGap);

        marginTop = dimensions.playerGap + 1.5 * dimensions.playerBox;
        match.find('.player:first').css('marginBottom', marginTop);
        round.append(match);
      }

    }

    bracket.append(round);
  };


  roundOf(true, 8);
  roundOf(false, 4);
  roundOf(false, 2);

  // // create a match html element
  // var createMatch = function() {
  //   addPlayers(match);
  //   return match;
  // };

  // // add players to a given match
  // var addPlayers = function(match) {
  //   var p1 = html.player(),
  //       p2 = html.player();

  //   p1.css("marginBottom", dimensions.playerGap + "px");
  //   match.append(p1).append(p2);
  // };

  // var round = createRound(0);

  // for (var i = 0; i < matches; i++) {
  //   round.append(createMatch());
  // }

  // bracket.append(round);


});
