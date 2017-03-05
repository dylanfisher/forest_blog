json.total_count @exhibitions.total_count
json.per_page @exhibitions.default_per_page

json.data @exhibitions do |item|
  json.id item.id
  json.text item.to_label
end
