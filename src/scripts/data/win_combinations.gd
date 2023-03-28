const _boardPositions := preload('res://src/scripts/enums/board_positions.gd').BoardPositions

const WinCombinations := [
	[self._boardPositions.TOP_LEFT, self._boardPositions.TOP_CENTER, self._boardPositions.TOP_RIGHT],
	[self._boardPositions.CENTER_LEFT, self._boardPositions.CENTER_CENTER, self._boardPositions.CENTER_RIGHT],
	[self._boardPositions.BOTTOM_LEFT, self._boardPositions.BOTTOM_CENTER, self._boardPositions.BOTTOM_RIGHT],
	[self._boardPositions.TOP_LEFT, self._boardPositions.CENTER_LEFT, self._boardPositions.BOTTOM_LEFT],
	[self._boardPositions.TOP_CENTER, self._boardPositions.CENTER_CENTER, self._boardPositions.BOTTOM_CENTER],
	[self._boardPositions.TOP_RIGHT, self._boardPositions.CENTER_RIGHT, self._boardPositions.BOTTOM_RIGHT],
	[self._boardPositions.TOP_LEFT, self._boardPositions.CENTER_CENTER, self._boardPositions.BOTTOM_RIGHT],
	[self._boardPositions.TOP_RIGHT, self._boardPositions.CENTER_CENTER, self._boardPositions.BOTTOM_LEFT],
]
