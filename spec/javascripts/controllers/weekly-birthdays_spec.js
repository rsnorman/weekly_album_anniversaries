describe('WeeklyBirthdaysCtrl', function() {
  var $scope;

  beforeEach(inject(function($controller, $rootscope) {
    $scope = $rootscope.$new();
    $controller('WeeklyBirthdaysCtrl', {
      $scope: $scope
    });
  }));

});