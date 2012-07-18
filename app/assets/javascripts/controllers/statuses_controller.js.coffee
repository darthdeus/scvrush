class @StatusesController

  constructor: ($scope, Statuses) ->
    $scope.statuses = Statuses.index()

    $scope.addStatus = (status) ->
      data = status: text: status
      Statuses.create data, ->
        Statuses.index (response) ->
          $scope.statuses = response
          $scope.status = ""

    $scope.deleteStatus = (status) ->
      # status.$delete id: status.id, ->
      Statuses.delete id: status.id, ->
        Statuses.index (response) ->
          $scope.statuses = response
          $scope.status = ""


  @$inject: ["$scope", "Statuses"]


