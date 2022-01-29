import React, { useEffect, useRef, useState } from 'react';
import classNames from 'classnames';
import { Chessground as NativeChessground } from 'chessground';

import useWindowSize from '@app/hooks/useWindowSize';
import { optimumBoardSize } from '@app/utils/board';

import BoardSkeleton from './BoardSkeleton';

const defaultConfig = {
  coordinates: false,
  highlight: {
    lastMove: true,
    check: true,
  },
  animation: {
    enabled: true,
    duration: 250,
  },
};

function Chessboard({
  theme,
  style,
  config,
}) {
  const chessgroundRef = useRef();
  const [api, setApi] = useState();

  const dimensions = useWindowSize();
  const size = optimumBoardSize(dimensions, 180);

  useEffect(() => {
    if (chessgroundRef.current && !api) {
      const finalConfig = { ...defaultConfig, ...config };
      const chessgroundApi = NativeChessground(chessgroundRef.current, finalConfig);
      setApi(chessgroundApi);
    } else if (chessgroundRef.current && api) {
      api.set(config);
    }
  }, [api, config]);

  return (
    <div
      className={classNames(
        'chessground',
        { [theme]: theme },
      )}
      ref={chessgroundRef}
      style={{
        height: size,
        width: size,
        ...style,
      }}
    />
  );
}

Chessboard.Skeleton = BoardSkeleton;

export default Chessboard;
