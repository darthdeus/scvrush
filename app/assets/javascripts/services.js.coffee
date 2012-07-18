module = angular.module("scvrush.services", ['ngResource'])

module.config(["$httpProvider", (provider) ->
  meta = $('meta[name=csrf-token]').attr('content')
  provider.defaults.headers.common['X-CSRF-Token'] = meta
])

module.factory("Tournament", ["$resource", ($resource) ->
  # TODO - extract tournament_id into an external service
  return $resource("/tournaments/" + gon.tournament_id + ".json",
    {},
    { get: { method: "GET", callback: "JSON_CALLBACK", isArray: true } })

])

module.factory("Statuses", ["$resource", ($resource) ->
  return $resource("/users/" + gon.user_id + "/statuses.json",
    {},
    {
      get: { method: "GET", callback: "JSON_CALLBACK", isArray: true },
      create: { method: "POST" }
    })
])
