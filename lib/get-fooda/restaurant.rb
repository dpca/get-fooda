class Restaurant
  attr_reader :name, :cuisine, :link

  def initialize(name, cuisine, link)
    @name = name
    @cuisine = cuisine
    @link = link
  end

  def self.parse(event)
    self.new(
      event.search('.myfooda-event__name').first.text,
      event.search('.myfooda-event__cuisine').first.text,
      event['href']
    )
  end

  def to_s
    "#{name} (#{cuisine})"
  end

  def slack_text
    "<#{link}|#{self.to_s})>"
  end
end
