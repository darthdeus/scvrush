Scvrush = Ember.Application.create({
  rootElement: $('.bracket-ember'),
  ready: function() {

    $('.bracket .player').live({
      mouseenter: function() {
        var cls = $(this)[0].className;
        // TODO - add backwards compatible #map
        cls = cls.split(' ').map(function(n) { return "." + n; }).join("")
        $(cls).addClass('player-highlight');
      },

      mouseleave:function() {
        var cls = $(this)[0].className;
        // TODO - add backwards compatible #map
        cls = cls.split(' ').map(function(n) { return "." + n; }).join("")
        $(cls).removeClass('player-highlight');
      }

    });
  }
});