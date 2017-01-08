(function(ng, module) {
  'use strict';

  function Artist ($http) {
    this.all = function() {
      var url;
      url = '/v1/admin/artists';
      return $http.get(url);
    };

    this.update = function(artist, attributes) {
      return $http.patch(artist.link, attributes);
    };
  }

  module.service('Artist', ['$http', Artist]);

})(angular, angular.module('Norm.WeeklyAnniversary'));
