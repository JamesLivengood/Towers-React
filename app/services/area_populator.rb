class AreaPopulator
  attr_reader :height, :width, :calculator, :fetcher
  def initialize(lat, lng, width, height)
    @height = height
    @width = width
    @calculator = LatLngCalculator.new
    @fetcher = AntennaSearchFetcher.new(lat, lng)
  end

  def populate!
    urls = []
    original_lng = fetcher.lng
    vertical_max = fetcher.lat + calculator.change_in_latitude(height + 1.8)
    horizontal_max = fetcher.lng - calculator.change_in_longitude(fetcher.lat, width - 1.8)

    until fetcher.lat > vertical_max
      until fetcher.lng < horizontal_max
        urls << fetcher.url
        fetcher.fetch!

        fetcher.move(:left, 1.8)
      end
      fetcher.lng = original_lng
      fetcher.move(:up, 1.8)
    end

    urls
  end
end