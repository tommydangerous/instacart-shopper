class FunnelsSerializer
  def initialize(start_date, end_date)
    @funnels_query = FunnelsQuery.new start_date, end_date
  end

  def serialize
    hash = {}
    @funnels_query.results.each do |object|
      monday = object["monday"]
      sunday = object["sunday"]
      key = [monday, sunday].join "-"
      hash[key] = {} if hash[key].nil?
      hash[key][object["workflow_state"]] = object["count"]
    end
    hash
  end

  private

  def default_applicant_hash
    array = Applicant::WORKFLOW_STATES.reject do |x|
      x == "background_check_authorized"
    end
    Hash[array.map { |x| [x, 0] }]
  end
end
