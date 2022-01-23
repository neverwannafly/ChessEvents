import React from 'react';

import Chessboard from '@app/lib/chessground';
import withLogin from '@app/hoc/withLogin';
import useChess from '@app/hooks/useChess';
import useWindowSize from '@app/hooks/useWindowSize';
import { optimumBoardSize } from '@app/utils/board';

function HomePage() {
  const {
    fen,
    lastMove,
    handlers: {
      legalMoves,
      turnColor,
      handleMove,
    },
  } = useChess();
  const dimensions = useWindowSize();
  const size = optimumBoardSize(dimensions, 180);

  return (
    <div className="cor-container p-h-20" style={{ color: '#ffffff' }}>
      <h1>Chess on Rails</h1>
      <Chessboard
        style={{ width: size, height: size }}
        theme="purple"
        config={{
          movable: legalMoves(),
          turnColor: turnColor(),
          lastMove,
          fen,
          events: {
            move: handleMove,
          },
        }}
      />
    </div>
  );
}

export default withLogin(HomePage);
