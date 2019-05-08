(function(ng, module) {
  'use strict';

  function ScheduledTweetsAdminCtrl ($scope, ScheduledTweet) {
    ScheduledTweet.all().then(function(response) {
      var scheduledTweetsData = response.data;

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
