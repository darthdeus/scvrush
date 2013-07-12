Scvrush.CalendarController = Ember.ArrayController.extend({

  tournaments: null,

  init: function() {
    this._super();
    this.set("model", this._weeksInCurrentMonth());

    var self = this;

    Scvrush.Tournament.find().then(function(tournaments) {
      self.set("tournaments", tournaments);
    })
  },

  currentMonthName: function() {
    return moment().utc().format("MMMM YYYY");
  }.property(),

  _weeksInCurrentMonth: function() {
    var monthStart = moment().utc().startOf("month"),
        monthEnd = moment().utc().endOf("month"),
        current = moment(monthStart).utc();

    var results = [];

    do {
      results.push(Scvrush.Calendar.Week.create({
        date: moment(current).utc().startOf("week"),
        controller: this
      }));

      current.add(1, "week");
    } while (current <= monthEnd);

    return results;
  },

});
