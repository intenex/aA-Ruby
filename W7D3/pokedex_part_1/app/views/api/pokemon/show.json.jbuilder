json.extract! @pokemon, :id, :name
json.image_url asset_path(@pokemon.image_url)
json.items do
  json.array! @pokemon.items do |item|
    json.extract! item, :name, :price, :happiness
    json.image_url asset_path(item.image_url)
  end
end