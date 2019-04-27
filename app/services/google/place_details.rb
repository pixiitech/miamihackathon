module Google
  class PlaceDetails
    attr_accessor :place_id

    def initialize(place_id)
      @place_id = place_id
    end

    def self.search(place_id)
      new(place_id).search
    end

    def endpoint_url
      [
        ENV['GOOGLE_PLACES_DETAILS_URL'],
        'json?',
        'key=',
        ENV['GOOGLE_PLACES_API_KEY'],
        '&inputtype=textquery',
        '&placeid=',
        place_id
      ].join
    end

    def search
      response = Faraday.get endpoint_url
      JSON.parse(response.body)
    end
  end
end
