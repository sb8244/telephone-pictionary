APP.controller('RoomGamesController', function($scope, $stateParams, Restangular) {
  function loadGames() {
    $scope.gameQuery.getList().then(function(games) {
      $scope.started = [];
      $scope.notStarted = [];
      $scope.finished = [];

      _.each(games, function(game) {
        if(game.finished) {
          $scope.finished.push(game);
        } else if(game.started) {
          $scope.started.push(game);
        } else {
          $scope.notStarted.push(game);
        }
      });
    });
  }

  Restangular.one('rooms', $stateParams.room_id).get().then(function(room) {
    $scope.room = room;
    $scope.gameQuery = room.all('games');
    loadGames();
  });

  $scope.createNewGame = function() {
    $scope.room.post("games", {}).then(function(game) {
      loadGames();
    }, function() {
      alert("Game could not be created");
    });
  };
});
