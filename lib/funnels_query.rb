class FunnelsQuery
  attr_reader :end_date, :start_date

  def initialize(s_date, e_date)
    @end_date = e_date
    @start_date = s_date
    @date_range_factory = DateRangeFactory.new start_date, end_date
  end

  def results
    ActiveRecord::Base.connection.execute sql
  end

  private

  def case_statement
    when_statements = []
    date_ranges.each_with_index do |array, index|
      when_statements << %{
        WHEN created_at >= '#{date_string array[0]}'
         AND created_at < '#{date_string array[1] + 1.day}' THEN #{index + 1}
      }
    end
    %{
      CASE
      #{when_statements.join(" ")}
      END
    }
  end

  def date_ranges
    @date_range_factory.ranges
  end

  def date_string(date)
    date.strftime "%Y-%m-%d"
  end

  def sql
    %{
      SELECT
        DATE(created_at, 'weekday 0', '-6 days') AS monday,
        DATE(created_at, 'weekday 0') AS sunday,
        workflow_state,
        COUNT() as count,
        #{case_statement}

      FROM Applicants

      WHERE created_at >= '#{date_string start_date}'
        AND created_at <= '#{date_string end_date}'

      GROUP BY
        workflow_state,
        #{case_statement}
      ;
    }
  end
end
