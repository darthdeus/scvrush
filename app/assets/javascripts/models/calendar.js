Scvrush.Calendar = Ember.Namespace.create();

Scvrush.Calendar.Day = Ember.Object.extend({
  date: null,
  week: null,
  tournament: null,

  dayInMonth: function() {
    return this.get("date").date();
  }.property("date"),

  isEmpty: function() {
    var tournaments = this.get("week.controller.tournaments"),
        result = true,
        self = this;

    if (tournaments) {
      var currentTournament = tournaments.find(function(tournament) {
        var tournamentStart = moment(tournament.get("startsAt")).utc().startOf("day"),
            day = self.get("date").utc().startOf("day");

        return day.toString() == tournamentStart.toString();
      });

      if (currentTournament) {
        this.set("tournament", currentTournament);
      }

      result = !currentTournament;
    }

    return result;
  }.property("date", "week.controller.tournaments.@each.startsAt")
});


Scvrush.Calendar.Week = Ember.Object.extend({
  date: null,
  controller: null,

  days: function() {
    var current = this.get("date").clone().startOf("week").utc(),
        weekEnd = current.clone().endOf("week").utc(),
        results = [];

    do {
      results.push(Scvrush.Calendar.Day.create({
        date: current.clone().utc(),
        week: this
      }));

      current.add(1, "day");
    } while (current <= weekEnd);

    return results;
  }.property("date")

});

