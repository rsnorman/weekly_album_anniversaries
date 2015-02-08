(function(ng, module, $) {
  'use strict';

  module.directive('appear', ['$window', function($window) {
    return {
      restrict: 'A',
      link: function($scope, $element) {
        function checkVisible() {
          var docViewTop, docViewBottom, padding, elemTop, elemBottom;

          docViewTop = $($window).scrollTop();
          docViewBottom = docViewTop + $($window).height();
          padding = 50;

          elemTop = $element.offset().top;
          elemBottom = elemTop + $element.height();

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