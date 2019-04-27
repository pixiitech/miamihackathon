module Teleport
  class CityProfile
    def self.call(geonameid)
      new(geonameid).profile
    end

    attr_reader :geonameid, :basic_info, :conn

    def initialize(geonameid)
      @geonameid  = geonameid
      @basic_info = Teleport::BasicInfo.call(geonameid)
    end

    def profile
      basic_info.merge(scores: scores)
    end

    private

    def scores
      Teleport::Scores.call(url)
    end

    def url
      basic_info[:urban_area]
    end
  end
end
