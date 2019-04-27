# frozen_string_literal: true

module Teleport
  BASE_URL = 'https://api.teleport.org/'

  def self.search(name)
    Teleport::Search.call(name)
  end

  def self.basic_info(geonameid)
    Teleport::BasicInfo.call(geonameid)
  end

  def self.scores(area_url)
    Teleport::Scores.call(area_url)
  end

  def self.city_profile(geonameid)
    Teleport::CityProfile.call(geonameid)
  end
end
