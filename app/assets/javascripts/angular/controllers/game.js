APP.controller('GameController', function($rootScope, $scope, $stateParams, Restangular, Game) {
  Game.load($stateParams.id);

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
      $scope.game = game;
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
