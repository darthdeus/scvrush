class @StatusesController

  constructor: ($scope, Statuses) ->
    window.s = Statuses
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
        # setTimeout ->
        Statuses.index (response) ->
          $scope.statuses = response
          $scope.status = ""
        # , 500


  @$inject: ["$scope", "Statuses"]


