import React, { Suspense, lazy } from 'react';
import { Provider } from 'react-redux';
import {
  BrowserRouter as Router,
  Switch,
  Route,
} from 'react-router-dom';

import store from '@app/store';

// Pages
const HomePage = lazy(() => import('@app/pages/home'));
const AboutPage = lazy(() => import('@app/pages/about'));
const AuthPage = lazy(() => import('@app/pages/auth'));
const NotFound = lazy(() => import('@app/pages/not_found'));

function AppRouter() {
  return (
    <Provider store={store}>
      <Router basename="/">
        <Suspense fallback={<h1>Loading...</h1>}>
          <Switch>
            <Route
              exact
              path="/"
              component={HomePage}
            />
            <Route
              exact
              path="/about"
              component={AboutPage}
            />
            <Route
              exact
              path="/auth"
              component={AuthPage}
            />
            <Route
              path="*"
              component={NotFound}
            />
          </Switch>
        </Suspense>
      </Router>
    </Provider>
  );
}

export default AppRouter;
