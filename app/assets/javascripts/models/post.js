Scvrush.Post = DS.Model.extend({
  title:   DS.attr("string"),
  content: DS.attr("string"),
  image:   DS.attr("string"),
  tagList: DS.attr("object")
});

Scvrush.Post.reopenClass({

  featuredPost: function() {
    return Scvrush.Post.query();
  }

});
