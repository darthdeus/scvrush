#= require_self
#= require_tree .

module = angular.module("scvrush.services", ['ngResource'])

module.config(["$httpProvider", (provider) ->
  meta = $('meta[name=csrf-token]').attr('content')
  provider.defaults.headers.common['X-CSRF-Token'] = meta
])

