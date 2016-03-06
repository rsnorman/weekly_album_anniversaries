(function(ng, module) {
  'use strict';

  function ArtistsAdminCtrl ($scope, Artist) {
    Artist.all().success(function(artistsData) {
      $scope.artists = artistsData.artists.map(function(artist) {
        artist.isEditing = !artist.twitter_screen_name;
        return artist;
      });
    });

    $scope.setTwitterScreenName = function(artist, screenName) {
      artist.isEditing = false;
      return Artist.update(artist, {
        twitter_screen_name: screenName
      }).success(function() {
        artist.twitter_screen_name = screenName;
      });
    };

    $scope.editTwitterScreenName = function(artist) {
      artist.isEditing = true;
      artist.previousTwitterScreenName = artist.twitter_screen_name;
    };

    $scope.clearTwitterScreenName = function(artist) {
      $scope.setTwitterScreenName(artist, null);
      artist.isEditing = true;
    };

    $scope.updateTwitterScreenName = function(artist) {
      $scope.setTwitterScreenName(artist, artist.twitter_screen_name).success(function() {
        artist.isEditing = false;
      });
    };

    $scope.cancelTwitterScreenNameEdit = function(artist) {
      artist.isEditing = false;
      artist.twitter_screen_name = artist.previousTwitterScreenName;
    };
  }

  module.controller(
    'ArtistsAdminCtrl',
    ['$scope', 'Artist', ArtistsAdminCtrl]
  );

})(angular, angular.module('Norm.WeeklyAnniversary'));
