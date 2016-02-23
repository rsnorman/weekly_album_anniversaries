(function(ng, module, $) {
  'use strict';

  module.directive('resetScroll', ['$window', function($window) {
    return {
      restrict: 'A',
      link: function($scope, $element, $attrs) {
        $scope.$watch($attrs.resetScroll, function(resetScroll) {
          if ( resetScroll ) {
            $($window).scrollTop(0);
          }
        });
      }
    }
  }]);

})(angular, angular.module('Norm.WeeklyAnniversary'), jQuery);
