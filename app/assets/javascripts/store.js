Scvrush.Store = DS.Store.extend({
  revision: 10,

  adapter: DS.RESTAdapter.create({
    bulkCommit: false,

    plurals: {
      match:  "matches",
      status: "statuses"
    },

    mappings: {
      user: "Scvrush.User",
      users: "Scvrush.User",
      tournament: "Scvrush.Tournament",
      tournaments: "Scvrush.Tournament"
    }

  }),

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


// Em.LOG_BINDINGS = true;
