APP.controller("GameWaitingController", function($scope) {
  $scope.$on('game:updated', function(e, game) {
    $scope.game = game;
  });
});
