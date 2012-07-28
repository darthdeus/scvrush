module = angular.module("scvrush.directives", [])

module.filter "capitalizeTag", ->
  (value) ->
    return "" unless value

    value = value.charAt(0).toUpperCase() + value.substring(1)
    if ["Eu", "Na", "Sea", "Kr"].indexOf(value) != -1
      value = value.toUpperCase()

    return value

module.directive "tag", ->
  return {
    restrict: "E",
    scope:
      tag: "@name"
    template: "<li><a href='/posts/tags/{{tag}}'>{{tag | capitalizeTag}}</a></li>"
  }
