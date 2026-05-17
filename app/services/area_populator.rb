class AreaPopulator
  RADIUS = 2.95
  # Make this 3? Check it's actually spitting back a 3 mile radius by downloading somewhere crowded
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

    total_rows = ((height + MOVE_DISTANCE) / MOVE_DISTANCE).ceil
    total_cols = ((width + MOVE_DISTANCE) / MOVE_DISTANCE).ceil
    total_steps = total_rows * total_cols
    completed = 0
    start_time = Time.now

    # Set midway points if passed
    fetcher.lat = lat
    fetcher.lng = lng

    until fetcher.lat > vertical_max
      until fetcher.lng < horizontal_max# || fetcher.lng < MAINLAND_AMERICA_WEST_MAX
        urls << fetcher.url
        fetcher.fetch!

        completed += 1
        elapsed = Time.now - start_time
        rate = completed / elapsed
        remaining = total_steps - completed
        eta_seconds = rate > 0 ? (remaining / rate).to_i : 0
        eta_str = "%02d:%02d:%02d" % [eta_seconds / 3600, (eta_seconds % 3600) / 60, eta_seconds % 60]
        puts "[#{completed}/~#{total_steps}] lat=#{fetcher.lat.round(5)}, lng=#{fetcher.lng.round(5)} | #{rate.round(2)} fetches/s | ETA #{eta_str} | RESUME_LAT=#{fetcher.lat.round(5)} RESUME_LNG=#{fetcher.lng.round(5)}"
        $stdout.flush

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