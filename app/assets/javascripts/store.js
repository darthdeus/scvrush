Scvrush.Store = DS.Store.extend({
  revision: 10,
  adapter: DS.RESTAdapter.create({
    bulkCommit: false
  })
});

Scvrush.store = Scvrush.Store.create();

Scvrush.store.adapter.serializer.map('Scvrush.TournamentDay', {
  tournaments: { embedded: 'load' }
});

Scvrush.store.adapter.serializer.map('Scvrush.Round', {
  matches: { embedded: 'load' }
});

// Em.LOG_BINDINGS = true;
