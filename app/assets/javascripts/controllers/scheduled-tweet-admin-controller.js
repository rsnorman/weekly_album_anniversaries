(function(ng, module) {
  'use strict';

  function ScheduledTweetsAdminCtrl ($scope, ScheduledTweet) {
    ScheduledTweet.all().success(function(scheduledTweetsData) {
      $scope.scheduledTweets = scheduledTweetsData.scheduled_tweets.map(function(scheduledTweet) {
        scheduledTweet.isEditing = false;
        return scheduledTweet;
      });
    });
  }

  module.controller(
    'ScheduledTweetsAdminCtrl',
    ['$scope', 'ScheduledTweet', ScheduledTweetsAdminCtrl]
  );

})(angular, angular.module('Norm.WeeklyAnniversary'));
