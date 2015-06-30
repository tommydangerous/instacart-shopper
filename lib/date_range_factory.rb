class DateRangeFactory
  attr_reader :end_date, :start_date

  def initialize(start_date, end_date)
    @start_date = start_date
    @end_date = end_date
  end

  def ranges
    s = start_date.beginning_of_week
    e = end_date.end_of_week
    (s..e).step(7).each_with_object([]) do |date, array|
      array << [date.beginning_of_week, date.end_of_week]
    end
  end
end
