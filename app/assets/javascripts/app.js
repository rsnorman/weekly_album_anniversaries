(function(ng, Norm) {
  'use strict';

  ng.module('Norm.WeeklyAnniversary', ['ngAnimate'])
    .config(['$httpProvider', '$sceProvider', function($httpProvider, $sceProvider) {
      $httpProvider.defaults.headers.common.Accept = 'application/json';
      $sceProvider.enabled(false)
    }]);

})(angular, window.Norm || {});