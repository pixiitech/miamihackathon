# frozen_string_literal: true

module Teleport
  class Search
    ENDPOINT = 'api/cities/'

    def self.call(name)
      new(name).search
    end

    attr_reader :name, :conn

    def initialize(name)
      @name = name
      @conn = Faraday.new(url: url)
    end

    def search
      conn.params['search'] = name
      response              = conn.get
      if response.success?
        JSON.parse(response.body)['_embedded']['city:search-results']
      end
    end

    private

    def url
      BASE_URL + ENDPOINT
    end
  end
end
