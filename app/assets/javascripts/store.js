Scvrush.Adapter = DS.RESTAdapter.extend();

Scvrush.Adapter.configure("plurals", {
  status: "statuses",
  match: "matches"
});

// Scvrush.Adapter.configure("Scvrush.Tournament", {
//   sideloadAs: "tournaments"
// });
//
// Scvrush.Adapter.configure("Scvrush.Status", {
//   sideloadAs: "statuses"
// });
// 
// Scvrush.Adapter.configure("Scvrush.User", {
//   sideloadAs: "users"
// });
// 
// Scvrush.Adapter.configure("Scvrush.User", {
//   sideloadAs: "users"
// });
// 
// Scvrush.Adapter.configure("Scvrush.Round", {
//   sideloadAs: "rounds"
// });
// 
// Scvrush.Adapter.configure("Scvrush.Match", {
//   sideloadAs: "matches"
// });

Scvrush.Store = DS.Store.extend({
  revision: 12,
  adapter: Scvrush.Adapter
});
