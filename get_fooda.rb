#!/usr/bin/env ruby

require 'nokogiri'
require 'open-uri'
require 'dotenv'

Dotenv.load

%w(COOKIE ACCOUNT BUILDING MEAL).each do |s|
  fail "Please set #{s} in the .env file" unless ENV.key?(s)
end

def parse_fooda_date(page)
  Date.parse(page.search('.cal__day--active').first['href'].gsub(/^\/my\?date=/, ''))
end

date = Date.today

url = 'https://app.fooda.com/my?' \
  "date=#{date.strftime('%Y-%m-%d')}" \
  "&filterable%5Baccount_id%5D=#{ENV['ACCOUNT']}" \
  "&filterable%5Bbuilding_id%5D=#{ENV['BUILDING']}" \
  "&filterable%5Bmeal_period%5D=#{ENV['MEAL']}"

result = Nokogiri::HTML(open(url, 'Cookie' => ENV['COOKIE']))
events = result.search('.myfooda-event__meta')
if events.any? && parse_fooda_date(result) == date
  events.each do |event|
    name = event.search('.myfooda-event__name').first
    cuisine = event.search('.myfooda-event__cuisine').first
    puts "#{name.text} (#{cuisine.text})" if name && cuisine
  end
end
