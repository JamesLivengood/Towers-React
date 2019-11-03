class AreaUrlGenerator
  attr_reader :height, :width, :calculator, :fetcher
  def initialize(lat, lng, width, height)
    @height = height
    @width = width
    @calculator = LatLngCalculator.new
    @fetcher = AntennaSearchFetcher.new(lat, lng)
  end

  def generate_urls!
    urls = []
    original_lng = fetcher.lng
    vertical_max = fetcher.lat + calculator.change_in_latitude(height + 2)
    horizontal_max = fetcher.lng - calculator.change_in_longitude(fetcher.lat, width - 2)

    until fetcher.lat > vertical_max
      until fetcher.lng < horizontal_max
        urls << fetcher.url
        fetcher.move(:left, 2)
      end
      fetcher.lng = original_lng
      fetcher.move(:up, 2)
    end

    urls
  end
end