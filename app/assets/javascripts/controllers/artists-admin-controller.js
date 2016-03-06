(function(ng, module) {
  'use strict';

  function ArtistsAdminCtrl ($scope, Artist) {
    Artist.all().success(function(artistsData) {
      $scope.artists = artistsData.artists;
    });

    $scope.setTwitterScreenName = function(artist, screenName) {
      Artist.update(artist, {
        twitter_screen_name: screenName
      }).success(function() {
        artist.twitter_screen_name = screenName;
      });
    };
  }

  module.controller(
    'ArtistsAdminCtrl',
    ['$scope', 'Artist', ArtistsAdminCtrl]
  );

})(angular, angular.module('Norm.WeeklyAnniversary'));
