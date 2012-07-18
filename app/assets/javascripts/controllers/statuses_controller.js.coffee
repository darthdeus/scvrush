class @StatusesController

  constructor: ($scope, Statuses) ->
    $scope.statuses = Statuses.get()

    $scope.addStatus = (status) ->
      data = status: text: status
      Statuses.create data, ->
        Statuses.get (response) ->
          $scope.statuses = response
          $scope.status = ""

  @$inject: ["$scope", "Statuses"]


