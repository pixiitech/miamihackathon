class EventsController < ApplicationController
  def index
    city = 'Miami' # session[:location] || 'Miami'
    date = 7.days.from_now #session[:date] || 7.days.from_now
    @events = Eventful.search(location: city, date: date)
  end
end
