Scvrush.MatchView = Em.View.extend({
  player1ClassName: function() {
    return "player player_" + this.get('content').player1;
  }.property('content.player1'),

  player2ClassName: function() {
    return "player player_" + this.get('content').player2;
  }.property('content.player2')

});