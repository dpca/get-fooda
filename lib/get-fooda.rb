require 'nokogiri'
require 'open-uri'
require 'dotenv'

Dotenv.load

fail 'Please set COOKIE in the .env file' unless ENV.key?('COOKIE')

require_relative 'get-fooda/event'
require_relative 'get-fooda/null_event'
require_relative 'get-fooda/restaurant'

class NoEventFound < StandardError; end
