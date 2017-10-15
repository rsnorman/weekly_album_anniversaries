(function(ng, module) {
  'use strict';

  function Album ($http) {
    this.all = function() {
      var url;
      url = '/v1/admin/albums';
      return $http.get(url);
    };

    this.update = function(album, attributes) {
      return $http.patch(album.update, {album: attributes});
    };
  }

  module.service('Album', ['$http', Album]);

})(angular, angular.module('Norm.WeeklyAnniversary'));
