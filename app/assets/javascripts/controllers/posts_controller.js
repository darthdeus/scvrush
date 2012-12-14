Scvrush.PostsController = Em.ArrayController.extend({
  query: null,

  updatePosts: _.debounce(function(value) {
    var posts;

    if (this.get("query") === "") {
      posts = Scvrush.get("store").find(Scvrush.Post);
    } else {
      posts = Scvrush.get("store").find(Scvrush.Post, { query: this.get("query") });
    }

    this.set("content", posts);
  }, 200),

  queryChanged: function(value) {
    this.updatePosts()
  }.observes("query")

});

Scvrush.TagsController = Em.ArrayProxy.extend({
  content: [Em.Object.create({name: "foo", id: 1}) ],
  selectedTags: []
});


Scvrush.TagView = Ember.View.extend({
  templateName: "tag_view"

//   didInsertElement: function() {
//     this.$('select').select2();
//   },
// 
//   itemsChanged: function() {
//     // flush the RunLoop so changes are written to DOM?
//     Ember.run.sync();
//     // trigger the 'liszt:updated'
//     Ember.run.next(this, function() {
//       this.$('select').trigger('liszt:updated');
//     });
//   }.observes('items.@each.name')

});

// Ember.run.later(function() {
//     // always use Ember.js methods to acces properties, so it should be
//     // `App.items.objectAt(0)` instead of `App.items.content[0]`
//     Scvrush.tags.objectAt(0).set('name', '1st Item');
// }, 1000);
