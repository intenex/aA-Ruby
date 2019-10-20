json.array! @guests do |guest| # love it right just like this
  if guest.age >= 40 && guest.age <= 50 # well that was trivially easy love it lol
    json.partial! 'api/guests/guest', guest: guest # omg amazing love it works great you totally get it love it
  end
end