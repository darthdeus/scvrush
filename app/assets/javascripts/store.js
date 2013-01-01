Scvrush.Adapter = DS.RESTAdapter.extend();

Scvrush.Adapter.configure("plurals", {
  status: "statuses",
  match: "matches"
});

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

Scvrush.store = Scvrush.Store.create();

// Scvrush.store.adapter.serializer.map('Scvrush.TournamentDay', {
//   tournaments: { embedded: 'load' }
// });

// Scvrush.store.adapter.serializer.map('Scvrush.Tournament', {
//   users: { embedded: 'load' }
// });

// Scvrush.store.adapter.serializer.map('Scvrush.Round', {
//   matches: { embedded: 'load' }
// });

// Scvrush.store.adapter.serializer.map('Scvrush.User', {
//   primaryKey: "username"
// });

// Em.LOG_BINDINGS = true;
