export const postUser = user => (
  $.ajax({
    method: "POST",
    url: '/api/users',
    data: { user }, // nested under the keyword of user so it's user: user brilliant smart yeah so require parameters works like this so great wow
  })
);

export const postSession = user => (
  $.ajax({
    url: '/api/session',
    method: 'POST',
    data: { user },
  })
);

export const deleteSession = () => (
  $.ajax({
    url: '/api/session',
    method: "DELETE"
  })
);