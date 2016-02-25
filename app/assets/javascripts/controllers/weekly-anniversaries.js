(function(ng, module) {
  'use strict';

  function WeeklyAnniversariesCtrl ($scope, Anniversary, $timeout, ImageLoader) {
    function getAnniversaries() {
      $scope.isLoading = true;

      Anniversary.all($scope.weekNumber).success(function(anniversaries) {
        ImageLoader.load(anniversaries.albums.map(function(album) {
          return album.thumbnail_url;
        })).then(function() {
          $scope.isLoading = false;
          $scope.isLoadingNext = false;
          $scope.isLoadingPrevious = false;


          $scope.weekStart = anniversaries.week_start;
          $scope.weekEnd = anniversaries.week_end;
          $scope.weekNumber = anniversaries.week_number;

          $scope.nextDisabled = $scope.weekNumber === 52;
          $scope.prevDisabled = $scope.weekNumber === 1;

          $scope.albumAnniversaries = anniversaries.albums;
        });
      });
    }

    Anniversary.search('kanye').success(function(anniversaries) {
      ImageLoader.load(anniversaries.albums.map(function(album) {
        return album.thumbnail_url;
      })).then(function() {
        $scope.isLoading = false;
        $scope.isLoadingNext = false;
        $scope.isLoadingPrevious = false;


        $scope.weekStart = anniversaries.week_start;
        $scope.weekEnd = anniversaries.week_end;
        $scope.weekNumber = anniversaries.week_number;

        $scope.nextDisabled = $scope.weekNumber === 52;
        $scope.prevDisabled = $scope.weekNumber === 1;

        $scope.albumAnniversaries = anniversaries.albums;
      });
    });

    $scope.isLoading  = true;
    $scope.daysOfWeek = [
      "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"
    ];

    $scope.getNextWeek = function() {
      if ($scope.weekNumber < 52) {
        $scope.weekNumber += 1;
        $scope.isLoadingNext = true;

        getAnniversaries();
      }
    };

    $scope.getPrevWeek = function() {
      if ($scope.weekNumber > 1) {
        $scope.weekNumber -= 1;
        $scope.isLoadingPrevious = true;

        getAnniversaries();
      }
    };

    getAnniversaries();
  }

  module.controller(
    'WeeklyAnniversariesCtrl',
    ['$scope', 'Anniversary', '$timeout', 'ImageLoader', WeeklyAnniversariesCtrl]
  );

})(angular, angular.module('Norm.WeeklyAnniversary'));
