module Teleport
  class Scores
    def self.call(area_url)
      new(area_url).scores
    end

    attr_reader :area_url, :conn

    def initialize(area_url)
      @area_url = area_url
      @conn     = Faraday.new(url: url)
    end

    def scores
      response = conn.get
      if response.success?
        JSON.parse(response.body)['categories']
      end
    end

    def url
      area_url + 'scores/'
    end
  end
end
