Scvrush.RoundsController = Em.ArrayController.extend({
  loadRounds: function() {
    var rounds = Scvrush.Round.findAll();
    this.set('content', rounds);
  }
});
