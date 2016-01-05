class Event
  attr_reader :date

  def self.create(date)
    event = self.new(date)
    if event.valid?
      event
    else
      NullEvent.new(date)
    end
  end

  def initialize(date)
    @date = date
  end

  def valid?
    @date == page_date && restaurants.any?
  end

  def to_slack_format
    { text: restaurants.map(&:slack_text).join("\n") }
  end

  def restaurants
    @restaurants_cache ||= page.search('.myfooda-event__restaurant').map { |e| Restaurant.parse(e) }
  end

  def to_s
    "#{page_date}: #{restaurants.map(&:to_s).join(', ')}"
  end

  private

  def page
    @page_cache ||= Nokogiri::HTML(open(fooda_url(@date), 'Cookie' => ENV['COOKIE']))
  end

  def page_date
    @date_cache ||= Date.parse(page.search('.cal__day--active').first['href'].gsub(/^\/my\?date=/, ''))
  end

  def fooda_url(date)
    "https://app.fooda.com/my?date=#{date.strftime('%Y-%m-%d')}"
  end
end
