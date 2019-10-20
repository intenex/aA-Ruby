export const fetchAllPokemon = () => (
  $.ajax({
    method: "GET",
    url: "/api/pokemon",
    success: resolve(data),
    error: rejects(error)
  })
); // by return a promise it just means return an ajax call which returns a promise like object lvoe ti lol