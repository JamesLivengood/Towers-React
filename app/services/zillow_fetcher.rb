class ZillowFetcher
  API_KEY = 'X1-ZWz16xtreutudn_3mmvk'.freeze

  def initialize
    @client = Zester::Client.new(API_KEY)
  end

  attr_reader :client
  private

end
