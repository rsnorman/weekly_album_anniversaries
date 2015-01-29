describe('WeeklyBirthdaysCtrl', function() {
  var Birthday, $http;

  beforeEach(module('FD.WeeklyBirthday'));

  beforeEach(inject(function(_Birthday_, _$http_) {
    Birthday = _Birthday_;
    $http = _$http_;
  }));

  describe('all', function() {
    it('should get all birthdays through http get', function() {
      spyOn($http, 'get');
      Birthday.all();
      expect($http.get).toHaveBeenCalledWith('/v1/birthdays');
    });
  });
});