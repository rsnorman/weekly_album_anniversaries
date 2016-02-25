(function(ng, module) {
  'use strict';

  function Anniversary ($http) {
    this.all = function(weekNumber) {
      var url;
      url = '/v1/anniversaries';
      if (!!weekNumber) {
        url += '?week_number=' + weekNumber;
      }
      return $http.get(url);
    };

    this.search = function(query) {
      var url;
      url = '/v1/albums?query=' + query;
      return $http.get(url);
    };
  }

  module.service('Anniversary', ['$http', Anniversary]);

})(angular, angular.module('Norm.WeeklyAnniversary'));
