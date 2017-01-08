(function(ng, module) {
  'use strict';

  function ScheduledTweet ($http) {
    this.all = function() {
      var url;
      url = '/v1/admin/scheduled_tweets';
      return $http.get(url);
    };

    this.update = function(scheduled_tweet, attributes) {
      return $http.patch(scheduled_tweet.link, attributes);
    };
  }

  module.service('ScheduledTweet', ['$http', ScheduledTweet]);

})(angular, angular.module('Norm.WeeklyAnniversary'));
