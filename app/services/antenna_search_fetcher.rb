# https://stackoverflow.com/questions/15804425/curl-on-ruby-on-rails
require 'net/http'
require 'open-uri'
class AntennaSearchFetcher
  attr_accessor :lat, :lng, :calculator, :options, :driver, :wait
  def initialize(lat, lng)
    @lat = lat
    @lng = lng
    @calculator = LatLngCalculator.new
    Capybara.javascript_driver = :webkit
    @options = Selenium::WebDriver::Chrome::Options.new(args: ['headless'])
    @driver = Selenium::WebDriver.for(:safari, options: options)
    @wait = Selenium::WebDriver::Wait.new(timeout: 180)
  end

  def fetch!
    return if SuccesfulDownload.where(lat: lat, lng: lng).exists?

    puts "Loading #{url}..."
    puts "#{lat}, #{lng}"
    sleep(1)
    driver.get(url)

    wait.until do
      driver.find_element(
        :css,
        "a[href*='/downloads_ant_free/Towers'], a[href*='1/1/2001'], a[href*='downloads_ant_free/TransmittersNAU228666HXX869054.csv'], a[href*='/downloads_ant_free/Transmitters'], a[href*='62.4161846226896']"
      )
    end

    tower_link = driver.find_elements(:css, "a[href*='/downloads_ant_free/Towers'], a[href*='1/1/2001'], a[href*='downloads_ant_free/TransmittersNAU228666HXX869054.csv']").first&.attribute('href')

    transmitter_link = driver.find_elements(:css, "a[href*='/downloads_ant_free/Transmitters'], a[href*='62.4161846226896']").first&.attribute('href')

    if tower_link == "http://www.antennasearch.com/1/1/2001"
      return
    end

    download_towers = tower_link.present? && tower_link.include?('downloads_ant_free/Towers')
    download_transmitters = transmitter_link.include?('downloads_ant_free/Transmitters')

    if download_towers
      # tower_download = open(tower_link)
      open('./towers/' + tower_link.split('/').last, 'wb') do |file|
        file << open(tower_link).read
      end
      # IO.copy_stream(tower_download, tower_link.split('/').last)
      # tower_text = File.read(tower_link.split('/').last)
      # # CSV.parse(tower_text, :headers => true)
      # CSV.open(tower_link.split('/').last, 'r', headers: true).each do |tower|
      #   Tower.create(tower.to_h.delete_if { |k, v| !k || k.empty? })
      # end
    end

    if download_transmitters
      # transmitter_download = open(transmitter_link)
      open('./transmitters/' + transmitter_link.split('/').last, 'wb') do |file|
        file << open(transmitter_link).read
      end
      # IO.copy_stream(transmitter_download, transmitter_link.split('/').last)
      # transmitter_text = File.read(transmitter_link.split('/').last)
      # # csv = CSV.parse(transmitter_text, :headers => true)
      # CSV.open(transmitter_link.split('/').last, 'r', headers: true).each do |transmitter|
      #   Transmitter.create(transmitter.to_h.delete_if { |k, v| !k || k.empty? })
      # end
    end

    SuccesfulDownload.create(
      url: url,
      lat: lat,
      lng: lng,
      had_towers: download_towers,
      had_transmitters: download_transmitters
    )

  rescue Selenium::WebDriver::Error::TimeoutError, OpenURI::HTTPError, Net::ReadTimeout, Net::OpenTimeout, Errno::ETIMEDOUT => error
    link_element = begin
      driver.find_element(:css, "a[href*='1/1/2001']")
    rescue Selenium::WebDriver::Error::NoSuchElementError, OpenURI::HTTPError, Net::ReadTimeout => e
      puts e
    end
    FailedDownload.create(url: url, lat: lat, lng: lng, error: error.to_s) unless link_element.present? # signifies on off-map location, so not an error
    puts error
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

# open('towers/image2.csv', 'wb') { |file| file << open('http://www.antennasearch.com/downloads_ant_free/TowersRVH426967AGQ495953.csv').read }
