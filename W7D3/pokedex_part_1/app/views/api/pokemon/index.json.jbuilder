json.array! @pokemon do |pokemon|
  json.set! pokemon.id do # why do you need a set vs just json.id pokemon.id hmm I guess if you want to call it the same thing hmm eh
    json.extract! pokemon, :id, :name
    json.image_url asset_path(pokemon.image_url) # ah smart lol always use the asset path to keep this dynamic if things change
  end
end