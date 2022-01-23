import React, { useEffect, useRef } from 'react';
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
    duration: 300,
  },
};

function Chessboard({
  theme,
  style,
  config,
}) {
  const chessgroundRef = useRef();
  const nativeChessgroundRef = useRef();
  const dimensions = useWindowSize();
  const size = optimumBoardSize(dimensions, 180);

  useEffect(() => {
    const finalConfig = { ...defaultConfig, ...config };
    if (!nativeChessgroundRef.current) {
      nativeChessgroundRef.current = NativeChessground(
        chessgroundRef.current,
        finalConfig,
      );
    } else {
      nativeChessgroundRef.current.set(finalConfig);
    }

    return () => {
      nativeChessgroundRef.current.destroy();
      nativeChessgroundRef.current = null;
    };
  }, [config]);

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
