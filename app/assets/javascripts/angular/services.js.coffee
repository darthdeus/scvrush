angular.injector(["ng"]).invoke ($rootScope) ->
  $rootScope.is = (type, value) -> return angular['is'+type](value)
  $rootScope.empty = (value) -> return $.isEmptyObject(value)
  $rootScope.log = (variable) -> console.log(variable)
  $rootScope.alert = (text) -> alert(text)

module = angular.module("scvrush.services", ["ngResource"])

module.config(["$httpProvider", (provider) ->
  meta = $('meta[name=csrf-token]').attr('content')
  provider.defaults.headers.common['X-CSRF-Token'] = meta
])

module.factory("Tournament", ["$resource", ($resource) ->
  # TODO - extract tournament_id into an external service
  return $resource("/tournaments/#{gon.tournament_id}/rounds", {},
    { get: { method: "GET", callback: "JSON_CALLBACK", isArray: true } })

])

module.factory("Statuses", ["$resource", ($resource) ->
  return $resource("/users/#{gon.user_id}/statuses/:id/:action", { id: '@id' },
    {
      index: { method: "GET", callback: "JSON_CALLBACK", isArray: true }
      create: { method: "POST" }
      delete: { method: "DELETE" }
      upvote: { method: "POST" }
    })
])

