(function(ng, module) {
  'use strict';

  function WeeklyBirthdayCtrl ($scope, Birthday, BirthdayGrouper) {
    $scope.daysOfWeek = [
      "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"
    ];

    Birthday.all().success(function(birthdays) {
      $scope.groupedBirthdays = BirthdayGrouper.group(birthdays);
    });
  }

  module.controller(
    'WeeklyBirthdayCtrl',
    ['$scope', 'Birthday', 'BirthdayGrouper', WeeklyBirthdayCtrl]
  );

})(angular, angular.module('FD.WeeklyBirthday'));