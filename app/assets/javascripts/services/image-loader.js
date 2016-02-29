(function(ng, module) {
  'use strict';

  function ImageLoader ($q) {
    this.load = function(imageUrls) {
      return $q(function(resolve) {
        var i, len, imageObjs, imageLoadCount;
        imageObjs = new Array();
        imageLoadCount = 0;

        function incrementLoadCount() {
          imageLoadCount += 1;
          if ( len == imageLoadCount ) {
            resolve();
          }
        }

        if ( imageUrls.length === 0 ) {
          resolve();
        }

        for ( i = 0, len = imageUrls.length; i < len; i++ ) {
          imageObjs[i] = new Image();
          imageObjs[i].onload = incrementLoadCount;
          imageObjs[i].src = imageUrls[i];
        }
      });
    };
  }

  module.service('ImageLoader', ['$q', ImageLoader]);

})(angular, angular.module('Norm.WeeklyAnniversary'));
