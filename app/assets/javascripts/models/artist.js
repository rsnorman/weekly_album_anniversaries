(function(ng, module) {
  'use strict';

  function Artist ($http) {
    this.all = function() {
      var url;
      url = '/v1/artists';
      return $http.get(url);
    };
  }

  module.service('Artist', ['$http', Artist]);

})(angular, angular.module('Norm.WeeklyAnniversary'));
