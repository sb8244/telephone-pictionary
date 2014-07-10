APP.directive('hardRedirect', function ($window) {
  return {
    restrict: 'A',
    link: function (scope, element, attr) {
      element.bind("click", function (e) {
        $window.location.href = attr.hardRedirect;
        e.stopPropagation();
        return false;
      });
    }
  };
});
