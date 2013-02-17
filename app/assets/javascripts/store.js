Scvrush.Adapter = DS.RESTAdapter.extend();

Scvrush.Adapter.configure("plurals", {
  status: "statuses",
  match: "matches"
});

Scvrush.Adapter.configure("Scvrush.Match", {
  sideloadAs: "matches"
});

Scvrush.Store = DS.Store.extend({
  revision: 11,
  adapter: Scvrush.Adapter
});
