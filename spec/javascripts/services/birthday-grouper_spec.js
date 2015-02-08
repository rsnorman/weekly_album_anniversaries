describe('WeeklyAnniversariesCtrl', function() {
  var AnniversaryGrouper;

  beforeEach(module('FD.WeeklyAnniversary'));

  beforeEach(inject(function(_AnniversaryGrouper_) {
    AnniversaryGrouper = _AnniversaryGrouper_;
  }));

  describe('group', function() {
    var Anniversaries;
    beforeEach(function() {
      Anniversaries = [{
        day_of_week: "Monday",
        name: "Ryan Norman"
      }, {
        day_of_week: "Saturday",
        name: "John Smith"
      }, {
        day_of_week: "Monday",
        name: "Dexter Norman"
      }];
    });

    it('should group Anniversaries on day of week', function() {
      var groupedAnniversaries;
      groupedAnniversaries = AnniversaryGrouper.group(Anniversaries);

      expect(groupedAnniversaries['Monday'][0].name).toEqual("Ryan Norman");
      expect(groupedAnniversaries['Monday'][1].name).toEqual("Dexter Norman");
      expect(groupedAnniversaries['Saturday'][0].name).toEqual("John Smith");
    });
  });
});