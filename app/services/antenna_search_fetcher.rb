# https://stackoverflow.com/questions/15804425/curl-on-ruby-on-rails
require 'net/http'
class AntennaSearchFetcher
  attr_reader :lat, :lng
  def initialize(lat:, lng:)
    @lat = lat
    @lng = lng
  end

  def fetch!
    uri = URI('http://antennasearch.com/')
    Net::HTTP.get(uri)
  end
end
