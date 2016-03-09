(function(ng, module) {
  'use strict';

  function WeeklyAnniversariesCtrl ($scope, Anniversary, $timeout, $location, ImageLoader) {

    function loadAlbumImages(albums) {
      return ImageLoader.load(albums.map(function(album) {
        return album.thumbnail_url;
      }));
    }

    function showAlbumAnniversaries(anniversaries) {
      $scope.isLoading = false;
      $scope.isLoadingNext = false;
      $scope.isLoadingPrevious = false;


      $scope.weekStart = anniversaries.week_start;
      $scope.weekEnd = anniversaries.week_end;
      $scope.weekNumber = anniversaries.week_number;

      $scope.nextDisabled = $scope.weekNumber === 52;
      $scope.prevDisabled = $scope.weekNumber === 1;

      $scope.albumAnniversaries = anniversaries.albums;
    }

    function showHighlightedAnniversary(anniversary) {
      $scope.highlightedAnniversary = anniversary;
    }

    function getAnniversaries() {
      $scope.isLoading = true;

      if ( $scope.highlightedAlbum ) {
        Anniversary.getHighlighted($scope.highlightedAlbum).success(function(anniversaries) {
          loadAlbumImages(anniversaries.albums.concat(anniversaries.highlighted_album)).then(function() {
            showHighlightedAnniversary(anniversaries.highlighted_album)
            showAlbumAnniversaries(anniversaries);
          });
        });
      } else {
        Anniversary.all($scope.weekNumber).success(function(anniversaries) {
          loadAlbumImages(anniversaries.albums).then(function() {
            showAlbumAnniversaries(anniversaries);
          });
        });
      }
    }

    $scope.isLoading  = true;
    $scope.daysOfWeek = [
      "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"
    ];
    $scope.highlightedAlbum = $location.absUrl().split('/albums/')[1];

    $scope.getNextWeek = function() {
      if ($scope.weekNumber < 52) {
        $scope.highlightedAnniversary = null;
        $scope.highlightedAlbum = null;
        $scope.weekNumber += 1;
        $scope.isLoadingNext = true;

        getAnniversaries();
      }
    };

    $scope.getPrevWeek = function() {
      if ($scope.weekNumber > 1) {
        $scope.highlightedAnniversary = null;
        $scope.highlightedAlbum = null;
        $scope.weekNumber -= 1;
        $scope.isLoadingPrevious = true;

        getAnniversaries();
      }
    };

    $scope.$watch('query', debounce(function(query) {
      if ( typeof query === 'undefined' ) {
        return;
      }

      if ( query.length === 0 ) {
        getAnniversaries();
      }

      if ( query.length > 3 ) {
        $scope.isLoading = true;
        $scope.albumAnniversaries = [];
        $scope.highlightedAnniversary = null;

        Anniversary.search(query).success(function(anniversaries) {
          loadAlbumImages(anniversaries.albums).then(function() {
            showAlbumAnniversaries(anniversaries);
          });
        });
      }
    }, 300));

    $scope.clearSearch = function() {
      $scope.query = '';
      getAnniversaries();
    };

    getAnniversaries();
  }

  module.controller(
    'WeeklyAnniversariesCtrl',
    ['$scope', 'Anniversary', '$timeout', '$location', 'ImageLoader', WeeklyAnniversariesCtrl]
  );

})(angular, angular.module('Norm.WeeklyAnniversary'));
