describe('WeeklyAnniversariesCtrl', function() {
  var AnniversaryMock, AnniversaryGrouperMock, $scope, $controller, Anniversaries;

  function initController() {
    $controller('WeeklyAnniversariesCtrl', {
      $scope          : $scope,
      Anniversary        : AnniversaryMock,
      AnniversaryGrouper : AnniversaryGrouperMock
    });
  }

  beforeEach(module('FD.WeeklyAnniversary'));

  beforeEach(inject(function(_$controller_, $rootScope) {
    $controller = _$controller_;
    $scope = $rootScope.$new();

    Anniversaries = [{
      name        : "Ryan Norman",
      age         : 30,
      day_of_week : "Monday"
    }];

    AnniversaryMock = {
      all: function() {
        return {
          success: function(callback) {
            callback(Anniversaries);
          }
        }
      }
    };

    AnniversaryGrouperMock = {
      group: function(Anniversaries) {
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

    describe('with first Anniversary on a Sunday', function() {
      beforeEach(function() {
        Anniversaries[0].day_of_week = 'Sunday';
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

    it('should set groupedAnniversaries', function() {
      expect($scope.groupedAnniversaries).toEqual({
        "Monday" : [{
          name : "Ryan Norman",
          age  : 30
        }]
      })
    });

    describe('before Anniversaries are returned', function() {
      beforeEach(function() {
        AnniversaryMock = {
          all: function() {
            return {
              success: function() {}
            }
          }
        };
        initController();
      });

      it('should set isLoading to true', function() {
        expect($scope.isLoading).toBeTruthy();
      });
    });

    describe('after Anniversaries are returned', function() {
      it('should set isLoading to true', function() {
        expect($scope.isLoading).toBeFalsy();
      });
    });
  });

});