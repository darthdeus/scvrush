Scvrush.DateTimeView = Em.TextField.extend({

  didInsertElement: function(foo, bar) {
    this.$().datetimepicker({ dateFormat: "yy-mm-dd", stepMinute: 5 });
  }

});
