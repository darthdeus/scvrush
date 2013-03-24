Scvrush.Adapter = DS.RESTAdapter.extend();

Scvrush.Adapter.configure("plurals", {
  status: "statuses",
  match: "matches"
});

Scvrush.Adapter.registerTransform("object", {
  deserialize: function(serialized) {
    if (serialized) {
      return serialized;
    } else if (serialized === null || serialized === undefined) {
      // if the value is not present in the data,
      // return undefined, not null.
      return serialized;
    } else {
      return null;
    }
  },

  serialize: function(object) {
    if (object) {
      return object;
    } else if (object === undefined) {
      return undefined;
    } else {
      return null;
    }
  }
});

Scvrush.Adapter.configure("Scvrush.Tournament", {
  sideloadAs: "tournaments"
});

Scvrush.Adapter.configure("Scvrush.Status", {
  sideloadAs: "statuses"
});

Scvrush.Adapter.configure("Scvrush.User", {
  sideloadAs: "users"
});

Scvrush.Adapter.configure("Scvrush.User", {
  sideloadAs: "users"
});

Scvrush.Adapter.configure("Scvrush.Round", {
  sideloadAs: "rounds"
});

Scvrush.Adapter.configure("Scvrush.Match", {
  sideloadAs: "matches"
});

Scvrush.Store = DS.Store.extend({
  revision: 12,
  adapter: Scvrush.Adapter
});
