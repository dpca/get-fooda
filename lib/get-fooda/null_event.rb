# Use this class for when no event could be found for the given day
class NullEvent
  attr_reader :date

  def initialize(date)
    @date = date
  end

  def to_slack_format
    { text: to_s }
  end

  def restaurants
    []
  end

  def to_s
    "#{@date}: No event found :("
  end
end
