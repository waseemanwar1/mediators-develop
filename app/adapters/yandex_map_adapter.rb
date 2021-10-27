class YandexMapAdapter
  extend ActionView::Helpers::DateHelper

  def self.get(collection)
    data = []

    collection.each_with_index do |item, i|

      data << {
        type: "Feature",
        id: i,
        geometry:
        {
          type: "Point",
          coordinates: [item.lat, item.lng]
        },
        properties:
        {
        },
        options:
        {
        }
      }
    end

    { type: "FeatureCollection", features: data }
  end
end
