APP.factory("Game", function($rootScope, Restangular) {
  var game = null;
  var lastId = null;

  var load = function(id) {
    lastId = id;
    Restangular.one("games", id).get().then(function(_game) {
      game = _game;
      window.game = game;
      game.playing = game.started && !game.finished;
      $rootScope.$broadcast('game:updated', game);
    });
  };

  return {
    load: load,

    refresh: function() {
      if(lastId) {
        load(lastId);
      }
    },

    get: function() {
      return game;
    }
  };
});
