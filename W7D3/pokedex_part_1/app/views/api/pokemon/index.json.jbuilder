json.array! @pokemon do |pokemon|
  json.set! pokemon.id do # why do you need a set vs just json.id pokemon.id hmm I guess if you want to call it the same thing hmm eh
    json.extract! pokemon, :id, :name
    json.image_url asset_path(poke.image_url) # ah smart lol
  end
end