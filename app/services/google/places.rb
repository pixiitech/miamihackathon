module Google
  class Places
    attr_accessor :keywords

    def initialize(keywords)
      @keywords = keywords
    end

    def self.search(keywords)
      new(keywords).search
    end

    def endpoint_url
      [
        ENV['GOOGLE_PLACES_SEARCH_URL'],
        'json?',
        'key=',
        ENV['GOOGLE_PLACES_API_KEY'],
        '&inputtype=textquery',
        '&input=',
        keywords
      ].join
    end

    def search
      response = Faraday.get endpoint_url
      JSON.parse(response.body)['candidates'].first['place_id']
    end
  end
end
