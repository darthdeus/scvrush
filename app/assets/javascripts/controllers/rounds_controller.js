Scvrush.RoundsController = Em.ArrayController.extend({
  rounds: [
    {
      type: "round",
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
      number: 1,
      matches: [
        { player1: "ham", player2: "jack" },
        { player1: "kara", player2: "lara" }
      ]
    },
    {
      type: "round",
      number: 2,
      matches: [
        { player1: "ham", player2: "kara" }
      ]
    }
  ]
});
