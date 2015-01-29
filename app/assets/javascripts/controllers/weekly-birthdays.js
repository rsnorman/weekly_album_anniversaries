(function(ng, module) {
  'use strict';

  function WeeklyBirthdaysCtrl ($scope, Birthday, BirthdayGrouper) {
    $scope.daysOfWeek = [
      "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"
    ];

    Birthday.all().success(function(birthdays) {
      if (birthdays[0] && birthdays[0].day_of_week === "Sunday") {
        $scope.daysOfWeek.unshift("Sunday");
      } else {
        $scope.daysOfWeek.push("Sunday");
      }

      $scope.groupedBirthdays = BirthdayGrouper.group(birthdays);
    });
  }

  module.controller(
    'WeeklyBirthdaysCtrl',
    ['$scope', 'Birthday', 'BirthdayGrouper', WeeklyBirthdaysCtrl]
  );

})(angular, angular.module('FD.WeeklyBirthday'));