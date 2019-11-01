# https://stackoverflow.com/questions/15804425/curl-on-ruby-on-rails
require 'net/http'
class AntennaSearchFetcher
  attr_reader :lat, :lng
  def initialize(lat, lng)
    @lat = lat
    @lng = lng
    @calculator = LatLngCalculator.new(lat, lng)
  end

  def fetch!
    uri = URI(url)
    Net::HTTP.get(uri)
  end

  def url
    "http://www.antennasearch.com/sitestart.asp?reportname001=antennacheck&raditem=002&reportname002=antennacheck&x=45&y=9&sourcepagename=SrchAnt&cmdRequest=process&latitude002=#{lat}&longitude002=#{lng}"
  end

  def move_2_miles(direction)
    case direction
    when :up
      @lng = lng + 1
    when :down
      @lng = lng - 1
    when :left
      @lat = lat - 1
    when :right
      @lat = lat + 1
    end
  end
end
