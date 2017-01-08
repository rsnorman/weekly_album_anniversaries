(function(ng, module) {
  'use strict';

  function ScheduledTweetCtrl ($scope, ScheduledTweet) {
    function updateScheduledAt(scheduledTweet, scheduledAt) {
      ScheduledTweet
        .scheduleAt(scheduledTweet, scheduledAt)
        .success(function(scheduledTweetData) {
          $scope.scheduledTweet = scheduledTweetData.scheduled_tweet;
        });
    }
    updateScheduledAt = debounce(updateScheduledAt, 500);

    $scope.$watch('scheduledTweet.scheduled_at', function(newValue, oldValue) {
      if ( newValue == oldValue ) {
        return;
      }
      updateScheduledAt($scope.scheduledTweet, newValue);
    });
  }

  module.controller(
    'ScheduledTweetCtrl',
    ['$scope', 'ScheduledTweet', ScheduledTweetCtrl]
  );

})(angular, angular.module('Norm.WeeklyAnniversary'));
