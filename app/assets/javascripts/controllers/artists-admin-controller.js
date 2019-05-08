(function(ng, module) {
  'use strict';

  function ArtistsAdminCtrl ($scope, Artist) {
    Artist.all().then(function(response) {
      var artistsData = response.data;

      $scope.artists = artistsData.artists.map(function(artist) {
        artist.isEditing = !artist.twitter_screen_name;
        return artist;
      });
    });

    $scope.setTwitterScreenName = function(artist, screenName) {
      artist.isEditing = false;
      return Artist.update(artist, {
        twitter_screen_name: screenName
      }).then(function() {
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
      $scope.setTwitterScreenName(artist, artist.twitter_screen_name).then(function() {
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
