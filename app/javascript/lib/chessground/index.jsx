import React, { useEffect, useRef } from 'react';
import classNames from 'classnames';
import { Chessground as NativeChessground } from 'chessground';

const defaultConfig = {
  coordinates: false,
  highlight: {
    lastMove: true,
    check: true,
  },
};
function Chessground({
  theme,
  style,
  config,
}) {
  const chessgroundRef = useRef();
  const nativeChessgroundRef = useRef();

  useEffect(() => {
    const finalConfig = { ...defaultConfig, config };
    if (!nativeChessgroundRef.current) {
      nativeChessgroundRef.current = NativeChessground(
        chessgroundRef.current,
        finalConfig,
      );
    } else {
      nativeChessgroundRef.set(finalConfig);
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
      style={style}
    />
  );
}

export default Chessground;
