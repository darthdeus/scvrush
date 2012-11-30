class @CoachesController
  constructor: ($scope, $resource) ->
    Coach = $resource("/admin/coaches.json", {}, {
      index: { method: "GET", isArray: true }
    })

    $scope.coaches = []

    $scope.loadMore = ->
      Coach.index (response) ->
         $scope.coaches = response

    $scope.loadMore()

  @$inject: ["$scope", "$resource"]
