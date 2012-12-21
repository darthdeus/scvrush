Scvrush.Store = DS.Store.extend({
  revision: 10,

  adapter: DS.RESTAdapter.create({
    bulkCommit: false,

    plurals: {
      match:  "matches",
      status: "statuses"
    }

    // init: function() {
    //   this.serializer.map("Scvrush.Tournament", {
    //     players: { embedded: "load" }
    //   });
    // }

  })
});

Scvrush.store = Scvrush.Store.create();

// Scvrush.store.adapter.serializer.map('Scvrush.TournamentDay', {
//   tournaments: { embedded: 'load' }
// });

// Scvrush.store.adapter.serializer.map('Scvrush.Tournament', {
//   users: { embedded: 'load' }
// });

Scvrush.store.adapter.serializer.map('Scvrush.Round', {
  matches: { embedded: 'load' }
});


// Em.LOG_BINDINGS = true;
