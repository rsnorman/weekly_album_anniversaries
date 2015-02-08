describe('WeeklyAnniversariesCtrl', function() {
  var Anniversary, $http;

  beforeEach(module('FD.WeeklyAnniversary'));

  beforeEach(inject(function(_Anniversary_, _$http_) {
    Anniversary = _Anniversary_;
    $http = _$http_;
  }));

  describe('all', function() {
    it('should get all Anniversaries through http get', function() {
      spyOn($http, 'get');
      Anniversary.all();
      expect($http.get).toHaveBeenCalledWith('/v1/Anniversaries');
    });
  });
});