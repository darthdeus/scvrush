class @CategoriesController
  constructor: ($scope) ->
    $scope.categories = JSON.parse(gon.categories)

  @$inject: ["$scope"]
