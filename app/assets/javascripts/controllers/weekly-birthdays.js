(function(ng, module) {
  'use strict';

  function WeeklyBirthdaysCtrl ($scope, Birthday, BirthdayGrouper) {
    $scope.daysOfWeek = [
      "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"
    ];

    Birthday.all().success(function(birthdays) {
      $scope.groupedBirthdays = BirthdayGrouper.group(birthdays);
    });
  }

  module.controller(
    'WeeklyBirthdaysCtrl',
    ['$scope', 'Birthday', 'BirthdayGrouper', WeeklyBirthdaysCtrl]
  );

})(angular, angular.module('FD.WeeklyBirthday'));