module Teleport
  class BasicInfo
    ENDPOINT = 'api/cities/geonameid'.freeze

    def self.call(geonameid)
      new(geonameid).basic_info
    end

    attr_reader :geonameid, :conn

    def initialize(geonameid)
      @geonameid = geonameid
      @conn      = Faraday.new(url: url)
    end

    def basic_info
      response = conn.get
      if response.success?
        city_info(JSON.parse(response.body))
      end
    end

    private

    def city_info(response_body)
      {
        name:       response_body['full_name'],
        lat:        response_body.dig('location', 'latlon', 'latitude'),
        lon:        response_body.dig('location', 'latlon', 'longitude'),
        population: response_body['population'],
        urban_area: response_body.dig('_links', 'city:urban_area', 'href')
      }
    end

    def url
      BASE_URL + ENDPOINT + ":#{geonameid}/"
    end
  end
end
