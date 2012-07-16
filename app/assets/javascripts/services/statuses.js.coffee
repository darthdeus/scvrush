module = angular.module("scvrush.services", ["ngResource"])

module.factory("Statuses", ["$resource", ($resource) ->
  return $resource("/users/" + gon.user_id + "/statuses.json",
    {},
    { get: { method: "GET", callback: "JSON_CALLBACK", isArray: true } })
])
