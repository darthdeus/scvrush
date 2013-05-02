Scvrush.Post = DS.Model.extend({
  title:   DS.attr("string"),
  content: DS.attr("string"),
  image:   DS.attr("string"),
  tagList: DS.attr("object"),

  relatedPosts: function() {
    Scvrush.Post.preloadPosts();

    var self = this;

    return Scvrush.Post.filter(function(post) {
      var tags = post.get("tagList"), i, l;
      var contains = false;

      for (i = 0, l = tags.length; i < l; i ++) {
        var tag = tags[i];

        if (self.get("tagList").contains(tag)) {
          contains = true;
        }
      }

      return contains;
    });
  }.property("tagList"),

  shortContent: function() {
    var content = this.get("content");

    if (content) {
      return content.slice(0, 400);
    }
  }.property("content")

});


(function() {
  var queried = false;

  Scvrush.Post.reopenClass({

    featuredPost: function() {
      return Scvrush.Post.query();
    },

    preloadPosts: function() {
      if (!queried) {
        queried = true;
        Scvrush.Post.query();
      }
    }

  });

})();
