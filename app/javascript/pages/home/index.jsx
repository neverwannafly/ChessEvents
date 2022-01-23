import React from 'react';

import Chessboard from '@app/lib/chessground';
import withLogin from '@app/hoc/withLogin';

function HomePage() {
  return (
    <div className="cor-container p-h-20" style={{ color: '#ffffff' }}>
      <h1>Chess on Rails</h1>
      <Chessboard style={{ width: 450, height: 450 }} theme="purple" />
    </div>
  );
}

export default withLogin(HomePage);
