(function(ng, module) {
  'use strict';

  function ArtistsAdminCtrl ($scope, Artist) {
    Artist.all()
  }

  module.controller(
    'ArtistsAdminCtrl',
    ['$scope', 'Artist', ArtistsAdminCtrl]
  );

})(angular, angular.module('Norm.WeeklyAnniversary'));
