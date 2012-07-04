var module = angular.module("scvrush", []);

// low level storage, such as localStorage
module.factory("tournaments", function() {
  if (!localStorage["todos"]) {
    var data = $('.todos').data('todos');
    localStorage["todos"] = JSON.stringify({todos: data});
  }

  return localStorage;
});

BracketCtrl.$inject = ["$scope", "$http"];
function BracketCtrl($scope, $http) {

  $http.get('/tournaments/1.json').success(function(data) {
    $scope.rounds = data.tournaments;

    setTimeout(function() { $('.bracket').applyDimensions(window.dimensions); }, 300);

  });

  $scope.inputResult = function(target) { debugger; };

};

