class @StatusesController

  constructor: ($scope, Statuses) ->
    $scope.statuses = Statuses.get()

  @$inject: ["$scope", "Statuses"]


