APP.controller('GamesController', function($scope, $stateParams, Restangular, $state) {
  function loadGames() {
    Restangular.all("games").getList().then(function(games) {
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

  loadGames();


  $scope.createNewGame = function() {
    Restangular.all("games").post().then(function(game) {
      $state.go("game", {id: game.id});
    }, function() {
      alert("Game could not be created");
    });
  };
});
