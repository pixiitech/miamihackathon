class ImagesController < ApplicationController
  def index
    if params[:search_keyword].present?
      session[:search_keyword] = params[:search_keyword]
      @city_image_urls = Google::PlacePhotos.search(params[:search_keyword])
      session[:city_image_urls] = @city_image_urls.to_json
    end
    @city_image_urls ||= JSON.parse(session[:city_image_urls] || '[]')
  end
end
