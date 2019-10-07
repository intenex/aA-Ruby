export const selectLocation = (city, jobs) => ({ // if you just have parentheses and no brackets it'll just return whatever's inside the parentheses which is an object here love it
  type: "SWITCH_LOCATION",
  city,
  jobs
});