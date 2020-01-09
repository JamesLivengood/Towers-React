class AreaPopulator
  RADIUS = 1.8
  MOVE_DISTANCE = RADIUS * Math.sqrt(3)
  MAINLAND_AMERICA_WEST_MAX = -124.587129

  attr_reader :height, :width, :calculator, :fetcher, :lat, :lng
  def initialize(lat, lng, width, height, midway_starting_lat=nil, midway_starting_lng=nil)
    @height = height
    @width = width
    @calculator = LatLngCalculator.new
    @fetcher = AntennaSearchFetcher.new(lat, lng)
    @lat = midway_starting_lat || lat
    @lng = midway_starting_lng || lng
  end

  def populate!
    urls = []
    original_lng = fetcher.lng
    vertical_max = fetcher.lat + calculator.change_in_latitude(height + MOVE_DISTANCE)
    horizontal_max = fetcher.lng - calculator.change_in_longitude(fetcher.lat, width + MOVE_DISTANCE)

    # Set midway points if passed
    fetcher.lat = lat
    fetcher.lng = lng

    until fetcher.lat > vertical_max
      until fetcher.lng < horizontal_max || fetcher.lng < MAINLAND_AMERICA_WEST_MAX
        urls << fetcher.url
        fetcher.fetch!

        fetcher.move(:left, MOVE_DISTANCE)
      end

      fetcher.lng = original_lng
      fetcher.move(:right, MOVE_DISTANCE / 2) if calculator.even_distance?(fetcher.lat, RADIUS)

      fetcher.move(:up, MOVE_DISTANCE)
    end

    urls
  ensure
    fetcher.driver&.quit
  end
end