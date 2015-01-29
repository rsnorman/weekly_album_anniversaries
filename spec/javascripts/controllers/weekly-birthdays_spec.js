describe('WeeklyBirthdaysCtrl', function() {
  var BirthdayMock, BirthdayGrouperMock, $scope, $controller, birthdays;

  function initController() {
    $controller('WeeklyBirthdaysCtrl', {
      $scope          : $scope,
      Birthday        : BirthdayMock,
      BirthdayGrouper : BirthdayGrouperMock
    });
  }

  beforeEach(module('FD.WeeklyBirthday'));

  beforeEach(inject(function(_$controller_, $rootScope) {
    $controller = _$controller_;
    $scope = $rootScope.$new();

    birthdays = [{
      name        : "Ryan Norman",
      age         : 30,
      day_of_week : "Monday"
    }];

    BirthdayMock = {
      all: function() {
        return {
          success: function(callback) {
            callback(birthdays);
          }
        }
      }
    };

    BirthdayGrouperMock = {
      group: function(birthdays) {
        return {
          "Monday" : [{
            name : "Ryan Norman",
            age  : 30
          }]
        };
      }
    };

    initController();
  }));

  describe('$scope', function() {
    it('should set the daysOfWeek', function() {
      expect($scope.daysOfWeek).toEqual(
        [
          'Monday', 'Tuesday', 'Wednesday', 'Thursday',
          'Friday', 'Saturday', 'Sunday'
        ]
      );
    });

    describe('with first birthday on a Sunday', function() {
      beforeEach(function() {
        birthdays[0].day_of_week = 'Sunday';
        initController();
      });

      it('should set the daysOfWeek', function() {
        expect($scope.daysOfWeek).toEqual(
          [
            'Sunday', 'Monday', 'Tuesday', 'Wednesday',
            'Thursday', 'Friday', 'Saturday'
          ]
        );
      });
    })

    it('should set groupedBirthdays', function() {
      expect($scope.groupedBirthdays).toEqual({
        "Monday" : [{
          name : "Ryan Norman",
          age  : 30
        }]
      })
    });
  });

});