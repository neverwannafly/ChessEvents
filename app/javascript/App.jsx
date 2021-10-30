import React, { Suspense, lazy } from 'react';
import { Provider } from 'react-redux';
import {
  BrowserRouter as Router,
  Switch,
  Route,
} from 'react-router-dom';

import store from '@app/store';
import './style';

// Pages
const HomePage = lazy(() => import('@app/pages/home'));
const NotFound = lazy(() => import('@app/pages/not_found'));

function AppRouter() {
  return (
    <div className="react-root">
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
                path="*"
                component={NotFound}
              />
            </Switch>
          </Suspense>
        </Router>
      </Provider>
    </div>
  );
}

export default AppRouter;
