(function(ng, module, $) {
  'use strict';

  var ALBUM_CHARS = '[album]'.length
  var ARTIST_CHARS = '[twitter]'.length
  var ALBUM_QUOTE_CHARS = 2

  module.directive('funFactTweetInput', [function() {
    return {
      restrict: 'E',
      scope: {
        placeholder: '@',
        maxlength: '=',
        album: '=',
        artist: '=',
        ngModel: '='
      },
      template: "<div><textarea ng-model='ngModel' placeholder='{{placeholder}}'></textarea><span>{{usedCharacters}}/{{maxlength}}</span></div>",
      link: function($scope, $element) {
        var $textarea = $element.find('textarea');
        $scope.usedCharacters = $textarea.val().length;

        $textarea.on('keyup', function(event) {
          $scope.$apply(function() {
            var description = $textarea.val();
            var totalCharacters = description.length;

            if (/\[album\]/.test(description)) {
              totalCharacters += ($scope.album.length + ALBUM_QUOTE_CHARS - ALBUM_CHARS);
            }

            if (/\[twitter\]/.test(description)) {
              totalCharacters += $scope.artist.length - ARTIST_CHARS;
            }

            $scope.usedCharacters = totalCharacters;
          })
        });
      }
    }
  }]);

})(angular, angular.module('Norm.WeeklyAnniversary'), jQuery);
