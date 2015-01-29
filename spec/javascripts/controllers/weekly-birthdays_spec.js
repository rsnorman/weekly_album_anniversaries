describe('WeeklyBirthdaysCtrl', function() {
  var $scope;

  beforeEach(module('FD.WeeklyBirthday'));

  beforeEach(inject(function($controller, $rootScope) {
    var BirthdayMock, BirthdayGrouperMock;
    $scope = $rootScope.$new();

    BirthdayMock = {
      all: function() {
        return {
          success: function(callback) {
            callback([{
              name        : "Ryan Norman",
              age         : 30,
              day_of_week : "Monday"
            }]);
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

    $controller('WeeklyBirthdaysCtrl', {
      $scope          : $scope,
      Birthday        : BirthdayMock,
      BirthdayGrouper : BirthdayGrouperMock
    });
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