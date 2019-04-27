class EventsController < ApplicationController
  def index
    city = session[:search_keyword] || 'Miami'
    date = session[:date] || 7.days.from_now
    @events = Eventful.search(location: city, date: date)
  end
end
