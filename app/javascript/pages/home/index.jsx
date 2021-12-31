import React from 'react';

import Chessboard from '@app/lib/chessground';

function HomePage() {
  return (
    <Chessboard style={{ height: 500, width: 500 }} theme="purple" />
  );
}

export default HomePage;
