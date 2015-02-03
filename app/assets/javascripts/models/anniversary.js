(function(ng, module) {
  'use strict';

  function Anniversary ($http) {
    this.all = function() {
      return $http.get('/v1/anniversaries');
    };
  }

  module.service('Anniversary', ['$http', Anniversary]);

})(angular, angular.module('Norm.WeeklyAnniversary'));