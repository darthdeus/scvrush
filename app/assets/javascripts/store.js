Scvrush.Adapter = DS.RESTAdapter.extend({
  serializer: DS.RESTSerializer.extend({
    init: function() {
      this._super();

      // this.map("Scvrush.Tournament", {
      //   rounds: { embedded: "load" }
      // });

//       this.map("Scvrush.Round", {
//         matches: { embedded: "load" }
//       });

    }
  }),

});

Scvrush.Adapter.configure("plurals", {
  status: "statuses",
  match: "matches"
});


// Scvrush.Adapter.configure("Scvrush.Tournament", {
//   sideloadAs: "tournament"
// });

Scvrush.Store = DS.Store.extend({
  revision: 11,
  adapter: Scvrush.Adapter.create({})

//   adapter: DS.RESTAdapter.create({
//     plurals: {
//       match:  "matches",
//       status: "statuses"
//     },
// 
//     mappings: {
//       user: "Scvrush.User",
//       users: "Scvrush.User",
//       tournament: "Scvrush.Tournament",
//       tournaments: "Scvrush.Tournament"
//     }
// 
//   }),

});

// Scvrush.store.adapter.serializer.map('Scvrush.TournamentDay', {
//   tournaments: { embedded: 'load' }
// });

// Scvrush.store.adapter.serializer.map('Scvrush.Tournament', {
//   users: { embedded: 'load' }
// });

// Scvrush.store.adapter.serializer.map('Scvrush.Round', {
//   matches: { embedded: 'load' }
// });

Em.LOG_BINDINGS = true;
