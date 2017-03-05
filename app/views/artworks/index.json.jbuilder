json.total_count @artworks.total_count
json.per_page @artworks.default_per_page

json.data @artworks do |item|
  json.id item.id
  json.text item.to_label
end
