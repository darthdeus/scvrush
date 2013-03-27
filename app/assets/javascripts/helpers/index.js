Ember.Handlebars.registerBoundHelper("index", function(item, collection) {
  return collection.indexOf(item);
});
