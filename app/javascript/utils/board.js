/* eslint-disable import/prefer-default-export */
export const optimumBoardSize = ({ height, width }, heightOffset = 0) => {
  const widthOffset = 50;
  const effectiveMaxHeight = height - heightOffset;
  const effectiveMaxWidth = width - widthOffset;

  return Math.min(effectiveMaxHeight, effectiveMaxWidth);
};
