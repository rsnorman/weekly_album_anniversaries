(function(ng, module) {
  'use strict';

  function BirthdayGrouper ($http) {
    this.group = function(birthdays) {
      var _i, _len, _bday, groupedBirthdays;

      groupedBirthdays = {};

      for (_i = 0, _len = birthdays.length; _i < _len; _i++) {
        _bday = birthdays[_i];
        groupedBirthdays[_bday.day_of_week]
          = groupedBirthdays[_bday.day_of_week] || [];

        groupedBirthdays[_bday.day_of_week].push(_bday);
      }

      return groupedBirthdays;
    };
  }

  module.service(
    'BirthdayGrouper',
    ['$http', function() { return new BirthdayGrouper(); }]
  );

})(angular, angular.module('FD.WeeklyBirthday'));