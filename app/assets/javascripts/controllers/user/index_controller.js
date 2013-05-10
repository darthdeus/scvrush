Scvrush.UserIndexController = Ember.ObjectController.extend({

  deleteStatus: function(status) {
    if (confirm("Are you sure?")) {
      status.deleteRecord();
      status.get("transaction").commit();
    }
  }

});
