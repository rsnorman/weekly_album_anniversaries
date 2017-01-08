(function(ng, Norm) {
  'use strict';

  ng.module('Norm.WeeklyAnniversary', ['ngAnimate', 'ngTouch', 'ngRoute', 'angularjs-datetime-picker'])
    .config(['$httpProvider', '$sceProvider', function($httpProvider, $sceProvider) {
      $httpProvider.defaults.headers.common.Accept = 'application/json';
      $sceProvider.enabled(false)
    }])
    .config(['$httpProvider', function($httpProvider) {
      $httpProvider.defaults.headers.common['X-CSRF-Token'] = document.getElementsByName('csrf-token')[0].content;
    }]);

})(angular, window.Norm || {});
