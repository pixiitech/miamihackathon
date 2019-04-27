class EventsController < ApplicationController
  def index
    city = session[:city] || 'Miami'
    date = session[:date] || 7.days.from_now
    @response = Eventful.search(city: city, date: date)
  end
end
