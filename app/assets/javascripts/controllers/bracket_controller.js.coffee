class @BracketController
  
  constructor: ($scope, Tournament) ->
    $scope.rounds = Tournament.get ->
      setTimeout ->
        $('.bracket').applyDimensions(window.dimensions)
      , 300

    $scope.inputResult = (match) ->
      if gon.is_admin
        document.location = "/matches/" + match.id + "/edit"

    $scope.editRound = (round) ->
      if gon.is_admin
        document.location = "/rounds/" + round.id + "/edit"

  @$inject = ["$scope", "Tournament"]
