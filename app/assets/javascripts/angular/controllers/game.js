APP.controller('GameController', function($rootScope, $scope, $stateParams, Restangular, Game, Pusher) {
  Game.load($stateParams.id);

  Pusher.subscribe('user-' + $rootScope.userId, 'game.load', function(gameId) {
    Game.load(gameId);
  });

  $scope.$on('game:updated', function(e, game) {
    $scope.game = game;

    if(game.finished) {
      game.customGET('history').then(function(history) {
        $scope.history = history;
      });
    }
  });

  $scope.startGame = function(game) {
    game.customPOST({}, "start").then(function(game) {
      Game.set(game);
    });
  };

  $scope.input = {};

  $scope.submitDrawing = function() {
    var canvas = $("#drawing").get()[0];
    var data = canvas.toDataURL();
    $scope.game.one("events").customPOST(
      { data: data, step: $scope.game.current_step, sequence: $scope.game.round_sequence }
    ).then(function() {
      Game.refresh();
    });
  };

  $scope.submitGuess = function() {
    $scope.game.one("events").customPOST(
      { data: $scope.input.guess, step: $scope.game.current_step, sequence: $scope.game.round_sequence }
    ).then(function() {
      Game.refresh();
    });
  };
});
