Scvrush.Store = DS.Store.extend({
  revision: 4,
  adapter: DS.RESTAdapter.create({
    bulkCommit: false
  })
});

Scvrush.store = Scvrush.Store.create();
