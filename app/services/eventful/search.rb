module Eventful
  class Search
    attr_reader :params

    def initialize(params)
      @params = params.merge(app_key: ENV['EVENTFUL_API_KEY'])
    end

    def self.call(params)
      new(params).search
    end

    def search
      conn = Faraday.new(url: 'http://api.eventful.com/rest/events/search') do |builder|
        builder.request :retry
        builder.params = params
        builder.response :logger
        builder.adapter :net_http
      end
      response = conn.get
      events = Ox.load(response.body).nodes.first.nodes.last.nodes
    end
  end
end
