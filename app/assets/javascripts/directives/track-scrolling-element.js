(function(ng, module, $) {
  'use strict';

  module.directive('trackScroll', ['$window', function($window) {
    return {
      restrict: 'A',
      link: function($scope, $element, $attrs) {
        var $scrollElement;
        $scrollElement = $($attrs.trackScroll);
        function checkVisible() {
          if ( $($window).scrollTop() > $scrollElement.offset().top ) {
            $element.addClass('scrolled-past');
          } else {
            $element.removeClass('scrolled-past');
          }
        }
        $($window).scroll(checkVisible).resize(checkVisible);
      }
    }
  }]);

})(angular, angular.module('Norm.WeeklyAnniversary'), jQuery);
