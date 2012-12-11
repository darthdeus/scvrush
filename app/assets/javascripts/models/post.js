Scvrush.Post = DS.Model.extend({
  id:      DS.attr("string"),
  title:   DS.attr("string"),
  content: DS.attr("string"),
  image:   DS.attr("string"),
  tags:    DS.attr("string")
});
