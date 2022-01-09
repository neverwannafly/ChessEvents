import React from 'react';
import { Route, Switch } from 'react-router-dom';

import LoginForm from './Login';
import RegistrationForm from './Registration';

function AuthPage() {
  return (
    <div className="auth-form__container">
      <Switch>
        <Route
          exact
          path="/signup"
          component={RegistrationForm}
        />

        <Route
          exact
          path="/signin"
          component={LoginForm}
        />
      </Switch>
    </div>
  )
}

export default AuthPage;
