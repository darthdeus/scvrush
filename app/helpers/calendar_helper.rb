module CalendarHelper
  def calendar(start = Date.today, &block)
    Calendar.new(self, start, block).table
  end

  class Calendar < Struct.new(:view, :start, :callback)
    HEADER = %w[Sun Mon Tue Wed Thu Fri Sat]
    # HEADER = []
    START_DAY = :sunday

    delegate :content_tag, to: :view

    def date
      start.to_date
    end

    def table
      content_tag :table, class: "calendar" do
        header + week_rows
      end
    end

    def header
      content_tag :tr do
        HEADER.map { |day| content_tag :th, day }.join.html_safe
      end
    end

    def week_rows
      weeks.map do |week|
        content_tag :tr do
          week.map { |day| day_cell(day) }.join.html_safe
        end
      end.join.html_safe
    end

    def day_cell(day)
      content_tag :td, view.capture(day, &callback), class: day_classes(day)
    end

    def day_classes(day)
      classes = []
      classes << "today" if day == Date.today
      classes << "notmonth" if day.month != date.month
      classes.empty? ? nil : classes.join(" ")
    end

    def weeks
      first = date.beginning_of_month.beginning_of_week(START_DAY)
      last = date.end_of_month.end_of_week(START_DAY)
      (first..last).to_a.in_groups_of(7)
    end
  end

  def title_for_date(date)
    day   = date.strftime("%d")
    month = date.strftime("%B")

    "Tournaments on #{day.to_i.ordinalize} #{month}"
  end

  def tournaments_popover(tournaments)
    tournaments.map { |tournament| tournament.name }.join(" ")
  end

end
