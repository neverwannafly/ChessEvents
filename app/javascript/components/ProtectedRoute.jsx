import React from 'react';
import { Redirect, Route } from 'react-router-dom';

function ProtectedRoute({
  component: Component,
  user,
  path,
  exact = false,
  ...rest
}) {
  return (
    <Route
      path={path}
      exact={exact}
      render={(props) => {
        if (user) {
          return <Component {...rest} {...props} />;
        }

        return (
          <Redirect to={{
            pathname: '/signup',
            state: {
              from: props.location,
            },
          }}
          />
        );
      }}
    />
  );
}

export default ProtectedRoute;
