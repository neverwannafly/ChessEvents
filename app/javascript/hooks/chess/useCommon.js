import { useEffect, useState } from 'react';
import Chess from 'chess.js';

import { turnColor } from './utils';

function useCommonHook(initialFen, _setOrientation) {
  const [chess] = useState(new Chess(initialFen));
  const [fen, setFen] = useState(initialFen);
  const [orientation, setOrientation] = useState();

  useEffect(() => {
    if (initialFen) {
      chess.load(initialFen);
      setFen(chess.fen());
      if (_setOrientation) {
        setOrientation(_setOrientation(chess));
      } else {
        setOrientation(turnColor(chess));
      }
    }
  }, [initialFen, chess, setFen, setOrientation]);

  return {
    fen,
    orientation,
    chess,
    setFen,
  };
}

export default useCommonHook;
