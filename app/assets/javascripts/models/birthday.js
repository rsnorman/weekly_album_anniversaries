(function(ng, module) {
  'use strict';

  function Birthday ($http) {
    this.all = function() {
      return $http.get('/v1/birthdays');
    };
  }

  module.service('Birthday', ['$http', Birthday]);

})(angular, angular.module('FD.WeeklyBirthday'));