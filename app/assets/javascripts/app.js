(function(ng, Norm) {
  'use strict';

  ng.module('Norm.WeeklyAnniversary', [])
    .config(['$httpProvider', function($httpProvider) {
      $httpProvider.defaults.headers.common.Accept = 'application/json';
      $httpProvider.defaults.headers.common.UUID = Norm.genreId;
    }]);

})(angular, window.Norm || {});