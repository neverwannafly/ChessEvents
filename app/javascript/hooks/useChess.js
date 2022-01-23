import { useState } from 'react';
import Chess from 'chess.js';

function useChess() {
  const [chess] = useState(new Chess());
  const [fen, setFen] = useState();
  const [lastMove, setLastMove] = useState();

  const handleMove = (from, to) => {
    if (chess.move({ from, to })) {
      setFen(chess.fen());
      setLastMove([from, to]);
    }
  };

  const turnColor = () => (
    chess.turn() === 'w' ? 'white' : 'black'
  );

  const legalMoves = () => {
    const movesMap = new Map();
    chess.SQUARES.forEach((square) => {
      const moves = chess.moves({ square, verbose: true });
      if (moves.length) {
        movesMap.set(square, moves.map((move) => move.to));
      }
    });

    return {
      free: false,
      dests: movesMap,
      color: turnColor(),
    };
  };

  return {
    chess,
    fen,
    lastMove,
    handlers: {
      legalMoves,
      turnColor,
      handleMove,
    },
  };
}

export default useChess;
