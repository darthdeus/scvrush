services = angular.module("scvrush-admin.services", ["ngResource"])
services.config(["$httpProvider", (provider) ->
  meta = $('meta[name=csrf-token]').attr('content')
  provider.defaults.headers.common['X-CSRF-Token'] = meta
])

module = angular.module("scvrush-admin", ["scvrush-admin.services"])

class @StaffController
  constructor: ($scope) ->
    $scope.categories = $("form.staff-form").data("staff") || []

    $scope.addPerson = (category) ->
      category.people.push
        name: ""
        avatar: ""
        attributes: []

    $scope.addCategory = (categories) ->
      categories.push
        category: ""
        people: []

    $scope.removeAttribute = (attributes, attribute) ->
      index = attributes.indexOf attribute
      attributes.splice index, 1

    $scope.addAttribute = (attributes) ->
      attributes.push ["", ""]

  @$inject: ["$scope"]
