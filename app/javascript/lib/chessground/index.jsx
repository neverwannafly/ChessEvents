import React, { useEffect, useMemo, useRef } from 'react';
import PropTypes from 'prop-types';
import classNames from 'classnames';
import { Chessground as NativeChessground } from 'chessground';

const propTypes = {
  fen: PropTypes.string,
  orientation: PropTypes.string,
  turnColor: PropTypes.string,
  check: PropTypes.bool,
  lastMove: PropTypes.array,
  selected: PropTypes.string,
  coordinates: PropTypes.bool,
  autoCastle: PropTypes.bool,
  viewOnly: PropTypes.bool,
  disableContextMenu: PropTypes.bool,
  resizable: PropTypes.string,
  addPieceZIndex: PropTypes.string,
  highlight: PropTypes.object,
  animation: PropTypes.object,
  movable: PropTypes.object,
  premovable: PropTypes.object,
  predroppable: PropTypes.object,
  draggable: PropTypes.object,
  selectable: PropTypes.object,
  onChange: PropTypes.func,
  onMove: PropTypes.func,
  onDropNewPiece: PropTypes.func,
  onSelect: PropTypes.func,
  items: PropTypes.object,
  drawable: PropTypes.object,
};

const defaultProps = {
  coordinates: false,
  highlight: {
    lastMove: true,
    check: true,
  },
};

function Chessground({
  theme,
  style,
  ...props
}) {
  const chessgroundRef = useRef();
  const nativeChessgroundRef = useRef();

  const componentProps = useMemo(() => {
    const config = { events: {} };
    Object.keys(propTypes).forEach((k) => {
      const v = props[k];
      if (typeof v !== 'undefined') {
        const match = k.match(/^on([A-Z]\S*)/);
        // Returns event listeners in lower case
        if (match) {
          config.events[match[1].toLowerCase()] = v;
        } else {
          config[k] = v;
        }
      }
    });

    return config;
  }, [props]);

  useEffect(() => {
    nativeChessgroundRef.current = NativeChessground(
      chessgroundRef.current,
      componentProps,
    );

    return () => {
      nativeChessgroundRef.current.destroy();
      nativeChessgroundRef.current = null;
    };
  }, []);

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

Chessground.propTypes = propTypes;
Chessground.defaultProps = defaultProps;

export default Chessground;
