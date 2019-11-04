# https://stackoverflow.com/questions/15804425/curl-on-ruby-on-rails
require 'net/http'
require 'open-uri'
class AntennaSearchFetcher
  attr_accessor :lat, :lng, :calculator
  def initialize(lat, lng)
    @lat = lat
    @lng = lng
    @calculator = LatLngCalculator.new
  end

  def fetch!
    Capybara.javascript_driver = :webkit
    options = Selenium::WebDriver::Chrome::Options.new(args: ['headless'])
    driver = Selenium::WebDriver.for(:chrome, options: options)
    wait = Selenium::WebDriver::Wait.new

    puts "Loading #{url}..."
    driver.get(url)

    tower_link = wait.until {
      driver.find_element(:css, "a[href*='/downloads_ant_free/Towers'], a[href*='1/1/2001']")
    }.attribute('href')

    transmitter_link = wait.until {
      driver.find_element(:css, "a[href*='/downloads_ant_free/Transmitters'], a[href*='62.4161846226896']")
    }.attribute('href')

    if tower_link == "http://www.antennasearch.com/1/1/2001"
      driver.quit
      return
    end

    sleep(1)

    tower_download = open(tower_link)
    transmitter_download = open(transmitter_link)

    IO.copy_stream(tower_download, tower_link.split('/').last)
    IO.copy_stream(transmitter_download, transmitter_link.split('/').last)

    CSV.new(tower_download, headers: true).each do |tower|
      Tower.create(tower.to_h.delete_if { |k, v| !k || k.empty? })
    end

    CSV.new(transmitter_download, headers: true).each do |transmitter|
      Transmitter.create(transmitter.to_h.delete_if { |k, v| !k || k.empty? })
    end

    driver.quit
    SuccessfulDownload.create(url: url, lat: lat, lng: lng)

  rescue Selenium::WebDriver::Error::TimeoutError, OpenURI::HTTPError
    link_element = begin
      driver.find_element(:css, "a[href*='1/1/2001']")
    rescue Selenium::WebDriver::Error::NoSuchElementError
    end
    FailedDownload.create(url: url, lat: lat, lng: lng) unless link_element.present? # signifies on off-map location, so not an error
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
