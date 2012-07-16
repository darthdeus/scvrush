//= require_self
//= require_tree .

BracketCtrl.$inject = ["$scope", "Tournament"];
function BracketCtrl($scope, Tournament) {

  $scope.rounds = Tournament.get(function() {
    setTimeout(function() { $('.bracket').applyDimensions(window.dimensions); }, 300);
  });

  $scope.inputResult = function(match) {
    if (gon.is_admin) {
      document.location = "/matches/" + match.id + "/edit";
    }
  };

  $scope.editRound = function(round) {
    if (gon.is_admin) {
      document.location = "/rounds/" + round.id + "/edit";
    }
  };

};
