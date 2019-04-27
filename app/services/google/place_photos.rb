# example use:
# Google::PlacePhotos.search('miami', 400, 120) will return an array of URLs
#
module Google
  class PlacePhotos
    MAX_PHOTO_WIDTH = 750
    MAX_PHOTO_HEIGHT = 120

    attr_accessor :photo_reference, :width, :height

    def initialize(photo_reference, width = MAX_PHOTO_WIDTH, height = MAX_PHOTO_HEIGHT)
      @photo_reference = photo_reference
      @width           = width
      @height          = height
    end

    def self.search(keyword, width, height)
      place_id = Places.search(keyword)
      place_details = PlaceDetails.search(place_id)
      references = place_details['result']['photos'].map { |photo| photo['photo_reference'] }
      references.map do |photo_ref|
        get_photo(photo_ref, width, height)
      end
    end

    def self.get_photo(photo_reference, width, height)
      new(photo_reference, width, height).get_photo
    end

    def endpoint_url(photo_reference)
      [
        ENV['GOOGLE_PLACES_PHOTO_URL'],
        'key=',
        ENV['GOOGLE_PLACES_API_KEY'],
        '&photoreference=',
        photo_reference,
        '&maxwidth=',
        width,
        '&maxheight=',
        height
      ].join
    end

    def get_photo
      resp = Faraday.get endpoint_url(photo_reference)
      # hack to parse 302 response
      resp.body.match(/(https:\/\/.+)/)[0].split('"').first
    end
  end
end
