APP.controller('RoomsController', function($scope, Restangular) {
  $scope.rooms = Restangular.all('rooms').getList().$object;
});
