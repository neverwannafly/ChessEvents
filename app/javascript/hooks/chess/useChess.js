import { useState } from 'react';

import useCommonHook from './useCommon';
import { legalMoves, turnColor } from './utils';

function useChess(initialFen) {
  const [lastMove, setLastMove] = useState();
  const {
    chess,
    fen,
    setFen,
    orientation,
  } = useCommonHook(initialFen);

  const handleMove = (from, to) => {
    if (chess.move({ from, to })) {
      setFen(chess.fen());
      setLastMove([from, to]);
    }
  };

  return {
    chess,
    fen,
    lastMove,
    legalMoves: legalMoves(chess),
    turnColor: turnColor(chess),
    handleMove,
    orientation,
  };
}

export default useChess;
