(function(ng, module, $) {
  'use strict';

  module.directive('swipe', [function() {
    return {
      restrict: 'A',
      link: function($scope, $element, $attrs) {
        $element.swipe({
          swipe: function(event, direction) {
            if (direction === 'left' && $attrs.swipeLeft) {
              $scope.$eval($attrs.swipeLeft);
            }

            if (direction === 'right' && $attrs.swipeRight) {
              $scope.$eval($attrs.swipeRight);
            }
          }
        });
      }
    }
  }]);

})(angular, angular.module('Norm.WeeklyAnniversary'), jQuery);