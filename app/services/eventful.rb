module Eventful

  def self.search(params)
    Eventful::Search.call(params)
  end

end
