require 'nokogiri'
require 'open-uri'
require 'dotenv'

Dotenv.load

%w(COOKIE ACCOUNT BUILDING MEAL).each do |s|
  fail "Please set #{s} in the .env file" unless ENV.key?(s)
end

require_relative 'get-fooda/event'
require_relative 'get-fooda/restaurant'

class NoEventFound < StandardError; end
