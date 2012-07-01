Scvrush.Round = Em.Object.extend({
});

Scvrush.Round.findAll = function() {
  return [
    {
      type: "round",
      round: 8,
      number: 1,
      matches: [
        { player1: "ham", player2: "burger" },
        { player1: "jack", player2: "john" },
        { player1: "kara", player2: "tiara" },
        { player1: "tara", player2: "lara" }
      ]
    },

    {
      type: "round",
      round: 4,
      number: 2,
      matches: [
        { player1: "ham", player2: "jack" },
        { player1: "kara", player2: "lara" }
      ]
    },

    {
      type: "round",
      round: 2,
      number: 3,
      matches: [
        { player1: "ham", player2: "kara" }
      ]
    }
  ]
};
