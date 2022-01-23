import { useCallback, useEffect, useState } from 'react';

import useCommonHook from './useCommon';
import {
  legalMoves,
  oppositeMove,
  parseLastMove,
  turnColor,
} from './utils';

function usePuzzle(initialFen, _solution) {
  const solution = _solution?.split(' ');
  const [lastMove, setLastMove] = useState();
  const [puzzleStage, setPuzzleStage] = useState(0);
  const [status, setStatus] = useState();

  const {
    chess,
    fen,
    orientation,
    setFen,
  } = useCommonHook(initialFen, (_chess) => (
    oppositeMove(_chess)
  ));

  useEffect(() => {
    if (puzzleStage === solution?.length) {
      setStatus('success');
    }
  }, [puzzleStage, solution, setStatus]);

  useEffect(() => {
    let timeout;

    if (solution && puzzleStage < solution.length) {
      const move = solution[puzzleStage];
      if (turnColor(chess) !== orientation) {
        timeout = setTimeout(() => {
          chess.move(move, { sloppy: true });
          setFen(chess.fen());
          setLastMove(parseLastMove(move));
          setPuzzleStage((prev) => prev + 1);
        }, 50);
      }
    }

    return () => {
      clearTimeout(timeout);
    };
  }, [solution, puzzleStage]);

  const cleanup = useCallback(() => {
    setLastMove();
    setPuzzleStage(0);
    setStatus();
  }, [setLastMove, setPuzzleStage, setStatus]);

  const handleMove = useCallback((from, to) => {
    if (puzzleStage === solution?.length) {
      return;
    }

    if (from + to === solution[puzzleStage]) {
      chess.move({ from, to });
      setFen(chess.fen());
      setLastMove([from, to]);
    } else {
      setFen(chess.fen());
      setLastMove([from, to]);
      setStatus('error');
    }
  }, [puzzleStage, chess, setFen, setLastMove, solution, setStatus]);

  const proxyLegalMoves = useCallback(() => {
    if (puzzleStage === solution?.length) {
      return {
        dests: new Map(),
        color: undefined,
        free: false,
      };
    }

    return legalMoves(chess);
  }, [chess, puzzleStage, solution]);

  return {
    status,
    chess,
    fen,
    lastMove,
    legalMoves: proxyLegalMoves(),
    turnColor: turnColor(chess),
    handleMove,
    orientation,
    cleanup,
  };
}

export default usePuzzle;
