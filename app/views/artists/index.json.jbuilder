json.total_count @artists.total_count
json.per_page @artists.default_per_page

json.data @artists do |item|
  json.id item.id
  json.text item.to_label
end
