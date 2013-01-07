Scvrush.DateTimeView = Em.TextField.extend({

  didInsertElement: function() {
    this.$().datetimepicker({ dateFormat: "yy-mm-dd", stepMinute: 5 });
  }

});
