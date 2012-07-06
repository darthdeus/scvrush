var module = angular.module("scvrush", ["ngResource"]);

module.factory("Tournament", ["$resource", function($resource) {
  return $resource("/tournaments/1.json", {},
                   { get: { method: "GET", callback: "JSON_CALLBACK", isArray: true } });

}]);

BracketCtrl.$inject = ["$scope", "Tournament"];
function BracketCtrl($scope, Tournament) {

  window.t = Tournament;
  $scope.rounds = Tournament.get(function() {
    setTimeout(function() { $('.bracket').applyDimensions(window.dimensions); }, 300);
  });

  $scope.inputResult = function(target) { debugger; };

};

