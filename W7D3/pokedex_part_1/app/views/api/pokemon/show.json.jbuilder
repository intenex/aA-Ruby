json.pokemon do
  json.extract! @pokemon, :id, :name, :attack, :defense, :moves, :poke_type, :item_ids
  json.image_url asset_path(@pokemon.image_url)
end
json.items do
  json.array! @pokemon.items do |item|
    json.set! item.id do # right this dynamically makes sense you want the key to be the item.id but you don't know what that is yet makes perfect sense love it way better than their readme actually so great so good to be productive now love it so lucky man
      json.extract! item, :name, :price, :happiness
      json.image_url asset_path(item.image_url) # man jbuilder is so easy to remember so amazing man love it just don't get set fully yet but that's about it doesn't seem like the most necessary very similar to GraphQL dynamism tbh hmm
  end
end