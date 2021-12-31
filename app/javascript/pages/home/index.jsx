import React from 'react';

import Chessboard from '@app/lib/chessground';

function HomePage() {
  return (
    <div className="cor-container">
      <h1>Chess on Rails</h1>
      <p>Stay tuned! This website is coming soon 😈</p>
      <p>Till then, here's a dummy board 😁</p>
      <Chessboard style={{ height: 400, width: 400, }} theme="purple" />
    </div>
  );
}

export default HomePage;
