import React from 'react';
import { connect } from 'react-redux';
import { withRouter, Route, Redirect } from 'react-router-dom';

// hmm yeah remembering it all is great

// unless logged out redirect wow love that you remmeber it all deep understanding is everything you can recreate it all if you rememeber it life is so great man all in the recalling this long way is the short way everything is so great
// These are the login and signup pages only show them if the user isn't already logged in so great
// oh damn missed a step yeah lol

const Auth = ({component: Component, exact, loggedIn, path}) => (
  <Route path={path} exact={exact} render={props => (
    !loggedIn ? (
      <Component {...props} />
    ) : (
      <Redirect to="/login" />
    )
  )} />
);

// only if logged in allow them to access these
// remember all jsx React components must be capitalized hence why we need to specifically name it we say map the key component: to the value Component that we can then use
// yeah just typing it all out by hand even if quickly makes a world of difference in muscle memory and really remembering it wow and if you only remember chunks you can extract the rest so well man recalling is so incredible
const Protected = ({component: Component, exact, loggedIn, path}) => (
  <Route path={path} exact={exact} render={props => (
    loggedIn ? (
      <Component {...props} />
    ) : (
      <Redirect to="/login" />
    )
  )} />
);

const mapStateToProps = state => ({
  loggedIn: Boolean(state.session.currentUser) // if there is a currentUser then let's call them logged in
});

export const AuthRoute = withRouter(connect(mapStateToProps)(Auth)); // right so pass this route component, exac, loggedIn, and path just like a Route love it ah in jsx that's how it works everything you pass as an attribute in the tag is part of a props object that's passed through amazing great to understand that
export const ProtectedRoute = withRouter(connect(mapStateToProps)(Protected));