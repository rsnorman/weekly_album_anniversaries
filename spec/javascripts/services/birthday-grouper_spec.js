describe('WeeklyAnniversariesCtrl', function() {
  var BirthdayGrouper;

  beforeEach(module('FD.WeeklyBirthday'));

  beforeEach(inject(function(_BirthdayGrouper_) {
    BirthdayGrouper = _BirthdayGrouper_;
  }));

  describe('group', function() {
    var birthdays;
    beforeEach(function() {
      birthdays = [{
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

    it('should group birthdays on day of week', function() {
      var groupedBirthdays;
      groupedBirthdays = BirthdayGrouper.group(birthdays);

      expect(groupedBirthdays['Monday'][0].name).toEqual("Ryan Norman");
      expect(groupedBirthdays['Monday'][1].name).toEqual("Dexter Norman");
      expect(groupedBirthdays['Saturday'][0].name).toEqual("John Smith");
    });
  });
});