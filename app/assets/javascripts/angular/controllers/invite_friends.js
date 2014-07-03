/*
 * $scope requires .game from parent controller
 */
APP.controller("InviteFriendsController", function($scope, Restangular) {
  $scope.input = {};
  $scope.game.all("users").getList().then(function(users) {
    $scope.users = users;
  });

  $scope.addUser = function(user) {
    $scope.game.customPOST({user_id: user.id}, 'invite').then(function() {
      $scope.game.game_length++;
      $scope.users.push(user);
      _.remove($scope.users, function(el) {
        return el === user;
      });
    });
  };

  $scope.sendInvite = function() {

  };
});
