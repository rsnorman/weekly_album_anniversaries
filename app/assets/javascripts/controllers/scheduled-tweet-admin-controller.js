(function(ng, module) {
  'use strict';

  function ScheduledTweetsAdminCtrl ($scope, ScheduledTweet) {
    ScheduledTweet.all().success(function(scheduledTweetsData) {
      $scope.scheduledTweets = scheduledTweetsData.scheduled_tweets.map(function(scheduledTweet) {
        scheduledTweet.isEditing = false;
        return scheduledTweet;
      });
    });

    $scope.editScheduledTweet = function(scheduledTweet) {
      scheduledTweet.isEditing = true;
      // scheduledTweet.previousScheduledTweet = scheduledTweet.twitter_screen_name;
    };

    $scope.clearScheduledTweet = function(scheduledTweet) {
      $scope.setScheduledTweet(scheduledTweet, null);
      scheduledTweet.isEditing = true;
    };

    $scope.updateScheduledTweet = function(scheduledTweet) {
      $scope.setScheduledTweet(scheduledTweet, scheduledTweet.twitter_screen_name).success(function() {
        scheduledTweet.isEditing = false;
      });
    };

    $scope.cancelScheduledTweetEdit = function(scheduledTweet) {
      scheduledTweet.isEditing = false;
      scheduledTweet.twitter_screen_name = scheduledTweet.previousTwitterScreenName;
    };
  }

  module.controller(
    'ScheduledTweetsAdminCtrl',
    ['$scope', 'ScheduledTweet', ScheduledTweetsAdminCtrl]
  );

})(angular, angular.module('Norm.WeeklyAnniversary'));
