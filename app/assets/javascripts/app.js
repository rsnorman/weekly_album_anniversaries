(function(ng, FD) {
  'use strict';

  ng.module('FD.WeeklyBirthday', [])
    .config(['$httpProvider', function($httpProvider) {
      $httpProvider.defaults.headers.common.Accept = 'application/json';
      $httpProvider.defaults.headers.common.UUID = FD.clientId;
    }])

})(angular, window.FD || {});