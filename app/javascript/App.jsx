import React, { Suspense } from 'react';
import { Provider } from 'react-redux';
import { BrowserRouter } from 'react-router-dom';
import { ThemeProvider } from '@mui/material';

import store from '@app/store';
import theme from '@app/constants/theme';

import AppRouter from './Router';
import Loader from './components/Loader';

function App() {
  return (
    <Provider store={store}>
      <ThemeProvider theme={theme}>
        <Suspense fallback={<Loader />}>
          <BrowserRouter>
            <AppRouter />
          </BrowserRouter>
        </Suspense>
      </ThemeProvider>
    </Provider>
  )
}

export default App;
