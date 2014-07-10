APP.controller("HeaderController", function($scope, Devise) {
  $scope.logout = Devise.logout;
})
