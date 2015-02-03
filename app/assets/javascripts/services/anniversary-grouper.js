(function(ng, module) {
  'use strict';

  function AnniversaryGrouper ($http) {
    this.group = function(anniversaries) {
      var _i, _len, _bday, groupedAnniversaries;

      groupedAnniversaries = {};

      for (_i = 0, _len = anniversaries.length; _i < _len; _i++) {
        _bday = anniversaries[_i];
        groupedAnniversaries[_bday.day_of_week]
          = groupedAnniversaries[_bday.day_of_week] || [];

        groupedAnniversaries[_bday.day_of_week].push(_bday);
      }

      return groupedAnniversaries;
    };
  }

  module.service(
    'AnniversaryGrouper',
    ['$http', function() { return new AnniversaryGrouper(); }]
  );

})(angular, angular.module('Norm.WeeklyAnniversary'));