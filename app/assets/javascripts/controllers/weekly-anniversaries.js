(function(ng, module) {
  'use strict';

  function WeeklyAnniversariesCtrl ($scope, Anniversary, AnniversaryGrouper) {
    $scope.isLoading  = true;
    $scope.daysOfWeek = [
      "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"
    ];

    Anniversary.all().success(function(anniversaries) {
      $scope.isLoading = false;

      if (anniversaries[0] && anniversaries[0].day_of_week === "Sunday") {
        $scope.daysOfWeek.unshift("Sunday");
      } else {
        $scope.daysOfWeek.push("Sunday");
      }

      $scope.albumAnniversaries = anniversaries;
    });
  }

  module.controller(
    'WeeklyAnniversariesCtrl',
    ['$scope', 'Anniversary', 'AnniversaryGrouper', WeeklyAnniversariesCtrl]
  );

})(angular, angular.module('Norm.WeeklyAnniversary'));