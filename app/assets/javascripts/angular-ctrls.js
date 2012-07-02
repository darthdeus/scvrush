var module = angular.module("bracket", []);

// low level storage, such as localStorage
module.factory("tournaments", function() {
  if (!localStorage["todos"]) {
    var data = $('.todos').data('todos');
    localStorage["todos"] = JSON.stringify({todos: data});
  }

  return localStorage;
});

// storage abstraciton
module.factory("bongo.storage", ["bongo.storage.lowlevel", function(lowlevel) {
  return {
    findAll: function() {
      return JSON.parse(lowlevel["todos"]);
    },
    dump: function(data) {
      lowlevel["todos"] = JSON.stringify(data);
    }
  };
}]);

var BracketCtrl = function($scope, $http) {

  $http.get('/tournaments/1.json').success(function(data) {
    $scope.rounds = data.tournaments;

    setTimeout(function() { $('.bracket').applyDimensions(window.dimensions); }, 300);

  });

  $scope.inputResult = function(target) { debugger; };

};

BracketCtrl.$inject = ["$scope", "$http"];

