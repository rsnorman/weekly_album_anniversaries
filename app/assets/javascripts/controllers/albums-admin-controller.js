(function(ng, module) {
  'use strict';

  function AlbumsAdminCtrl ($scope, Album) {
    Album.all().then(function(response) {
      var albumsData = response.data;

      $scope.albums = albumsData.albums.map(function(album) {
        album.isEditing = !album.fun_fact_description;
        return album;
      });
    });

    $scope.setFunFact = function(album, funFactDescription, funFactSource) {
      album.isEditing = false;
      return Album.update(album, {
        fun_fact_description: funFactDescription,
        fun_fact_source: funFactSource
      }).then(function(response) {
        var updatedAlbum = response.data;

        album.fun_fact_description = updatedAlbum.fun_fact_description;
        album.generated_fun_fact_description = updatedAlbum.generated_fun_fact_description;
        album.fun_fact_source = updatedAlbum.fun_fact_source;
      });
    };

    $scope.editFunFact = function(album) {
      album.isEditing = true;
      album.previousFunFact = album.fun_fact_description;
      album.previousFunFactSource = album.fun_fact_source;
    };

    $scope.clearFunFact = function(album) {
      $scope.setFunFact(album, null);
      album.isEditing = true;
    };

    $scope.updateFunFact = function(album) {
      $scope.setFunFact(album, album.fun_fact_description, album.fun_fact_source).then(function() {
        album.isEditing = false;
      });
    };

    $scope.cancelFunFactEdit = function(album) {
      album.isEditing = false;
      album.fun_fact_description = album.previousFunFact;
      album.fun_fact_source = album.previousFunFactSource;
    };

    $scope.wikipediaSearchQueryString = function(album) {
      return 'https://en.wikipedia.org/wiki/Special:Search?search=' + album.artist.replace(/\s/g, '+') + '+' + album.name.replace(/\s/g, '+');
    }
  }

  module.controller(
    'AlbumsAdminCtrl',
    ['$scope', 'Album', AlbumsAdminCtrl]
  );

})(angular, angular.module('Norm.WeeklyAnniversary'));
