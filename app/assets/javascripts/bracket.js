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


function BracketCtrl($scope, $http) {

  $http.get('/tournaments/1.json').success(function(data) {
    $scope.rounds = data.tournaments;
    // TODO - make this better
    setTimeout(function() {
      // $scope.$watch('rounds', function() {
      $('.bracket').applyDimensions(window.dimensions);
      // });
    }, 500);

  });

}

jQuery(function($) {

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
