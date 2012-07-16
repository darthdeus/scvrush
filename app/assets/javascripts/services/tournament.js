var module = angular.module("scvrush", ["ngResource"]);

module.factory("Tournament", ["$resource", function($resource) {
  // TODO - extract tournament_id into an external service
  return $resource("/tournaments/" + gon.tournament_id + ".json", {},
                   { get: { method: "GET", callback: "JSON_CALLBACK", isArray: true } });

}]);
