class @StatusesController

  constructor: ($scope, Statuses, $http) ->
    window.s = Statuses
    $scope.statuses = Statuses.index()

    $scope.upvoteStatus = (status) ->
      $('[rel=tooltip]').tooltip('hide')
      status.$upvote action: "upvote", (res) ->
        console.log res
        console.log "upvoted"

    $scope.addStatus = (status) ->
      data = status: text: status
      Statuses.create data, ->
        Statuses.index (response) ->
          $scope.statuses = response
          $scope.status = ""

    $scope.deleteStatus = (status) ->

      Statuses.delete id: status.id, ->
        # setTimeout ->
        Statuses.index (response) ->
          $scope.statuses = response
          $scope.status = ""
        # , 500

  @$inject: ["$scope", "Statuses", "$http"]
