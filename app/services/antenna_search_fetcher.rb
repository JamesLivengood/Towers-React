# https://stackoverflow.com/questions/15804425/curl-on-ruby-on-rails
require 'net/http'
class AntennaSearchFetcher
  attr_accessor :lat, :lng, :calculator
  def initialize(lat, lng)
    @lat = lat
    @lng = lng
    @calculator = LatLngCalculator.new
  end

  def fetch!
    options = Selenium::WebDriver::Chrome::Options.new(args: ['headless'])
    driver = Selenium::WebDriver.for(:chrome, options: options)

    driver.get(url)

    tower_link = wait.until do
      driver.find_element(:css, "a[href*='/downloads_ant_free/Towers']")
    end

    transmitter_link = wait.until do
      driver.find_element(:css, "a[href*='/downloads_ant_free/Towers']")
    end



    driver.quit
  end

  def url
    "http://www.antennasearch.com/sitestart.asp?reportname001=antennacheck&raditem=002&reportname002=antennacheck&x=45&y=9&sourcepagename=SrchAnt&cmdRequest=process&latitude002=#{lat}&longitude002=#{lng}"
  end

  def move(direction, distance)
    # Distance is in miles
    case direction
    when :up
      @lat = lat + calculator.change_in_latitude(distance)
    when :down
      @lat = lat - calculator.change_in_latitude(distance)
    when :right
      @lng = lng + calculator.change_in_longitude(lat, distance)
    when :left
      @lng = lng - calculator.change_in_longitude(lat, distance)
    end
  end

  def coords
    [lat, lng]
  end
end
