(function(ng, module, $) {
  'use strict';

  module.directive('appear', ['$window', function($window) {
    return {
      restrict: 'A',
      link: function($scope, $element) {
        function checkVisible() {
          var docViewTop = $($window).scrollTop();
          var docViewBottom = docViewTop + $($window).height();
          var padding = 50;

          var elemTop = $element.offset().top;
          var elemBottom = elemTop + $element.height();

          if ((elemBottom <= docViewBottom - padding) && (elemTop >= docViewTop + padding)) {
            $element.addClass('appear');
          } else {
            $element.removeClass('appear');
          }
        }

        $($window).scroll(checkVisible).resize(checkVisible);
      }
    }
  }]);

})(angular, angular.module('Norm.WeeklyAnniversary'), jQuery);