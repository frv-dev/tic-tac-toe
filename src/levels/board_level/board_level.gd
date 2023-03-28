extends Node2D
class_name BoardLevel


const _players := preload('res://src/scripts/enums/players.gd').Players
const _winners := preload('res://src/scripts/enums/winners.gd').Winners
const _boardPositions := preload('res://src/scripts/enums/board_positions.gd').BoardPositions

const _winCombinations := preload('res://src/scripts/data/win_combinations.gd').WinCombinations

var actualPlayer: _players
var gameOver: bool
var boardData: Dictionary
var boardButtons: Dictionary
var winnerText: Label


func _ready() -> void:
	_setInitialData()
	_registerButtons()
	_registerWinnerText()
	_clearWinnerText()


func _setInitialData() -> void:
	actualPlayer = _players.CROSS
	gameOver = false
	boardData = {
		_boardPositions.TOP_LEFT: null,
		_boardPositions.TOP_CENTER: null,
		_boardPositions.TOP_RIGHT: null,
		_boardPositions.CENTER_LEFT: null,
		_boardPositions.CENTER_CENTER: null,
		_boardPositions.CENTER_RIGHT: null,
		_boardPositions.BOTTOM_LEFT: null,
		_boardPositions.BOTTOM_CENTER: null,
		_boardPositions.BOTTOM_RIGHT: null,
	}


func _registerButtons() -> void:
	boardButtons = {
		_boardPositions.TOP_LEFT: $Board/BoardButtons/BoardButtonTL,
		_boardPositions.TOP_CENTER: $Board/BoardButtons/BoardButtonTC,
		_boardPositions.TOP_RIGHT: $Board/BoardButtons/BoardButtonTR,
		_boardPositions.CENTER_LEFT: $Board/BoardButtons/BoardButtonCL,
		_boardPositions.CENTER_CENTER: $Board/BoardButtons/BoardButtonCC,
		_boardPositions.CENTER_RIGHT: $Board/BoardButtons/BoardButtonCR,
		_boardPositions.BOTTOM_LEFT: $Board/BoardButtons/BoardButtonBL,
		_boardPositions.BOTTOM_CENTER: $Board/BoardButtons/BoardButtonBC,
		_boardPositions.BOTTOM_RIGHT: $Board/BoardButtons/BoardButtonBR,
	}

	for boardPosition in boardButtons.keys():
		var boardButtonNode = boardButtons[boardPosition]

		boardButtonNode.connect(
			'click',
			func (): _makeMovement(boardPosition, boardButtonNode)
		)


func _registerWinnerText() -> void:
	winnerText = $WinnerText


func _clearWinnerText() -> void:
	winnerText.text = ''


func _clearBoard() -> void:
	for boardPosition in boardButtons:
		var crossSymbol: Node2D = boardButtons[boardPosition].find_child('Cross')
		var circleSymbol: Node2D = boardButtons[boardPosition].find_child('Circle')

		crossSymbol.visible = false
		circleSymbol.visible = false

		boardButtons[boardPosition].isPressed = false


func _makeMovement(boardPosition: _boardPositions, boardButton: BoardButton) -> void:
	if boardData[boardPosition] != null or gameOver:
		return

	_setBoardDataForPlayer(boardPosition)
	_drawSymbolOnBoard(boardButton, actualPlayer)
	_togglePlayer()
	var winner := _verifyWinner()
	_showWinner(winner)


func _setBoardDataForPlayer(boardPosition: _boardPositions) -> void:
	boardData[boardPosition] = actualPlayer


func _drawSymbolOnBoard(boardButton: BoardButton, player: _players) -> void:
	var symbol: Node2D

	if player == _players.CROSS:
		symbol = boardButton.find_child('Cross')
	else:
		symbol = boardButton.find_child('Circle')

	symbol.visible = true


func _togglePlayer() -> void:
	if actualPlayer == _players.CROSS:
		actualPlayer = _players.CIRCLE
	else:
		actualPlayer = _players.CROSS


func _verifyWinner() -> _winners:
	for winCombination in _winCombinations:
		if (
			boardData[winCombination[0]] == _players.CROSS
			and boardData[winCombination[1]] == _players.CROSS
			and boardData[winCombination[2]] == _players.CROSS
		):
			return _winners.CROSS

		if (
			boardData[winCombination[0]] == _players.CIRCLE
			and boardData[winCombination[1]] == _players.CIRCLE
			and boardData[winCombination[2]] == _players.CIRCLE
		):
			return _winners.CIRCLE

	for itemBoardData in boardData.values():
		if itemBoardData == null:
			return _winners.NONE

	return _winners.DRAW


func _showWinner(winner: _winners) -> void:
	if winner == _winners.NONE:
		return

	gameOver = true

	if winner == _winners.CROSS:
		winnerText.text = 'GANHADOR - X'
	elif winner == _winners.CIRCLE:
		winnerText.text = 'GANHADOR - O'
	elif winner == _winners.DRAW:
		winnerText.text = 'EMPATE'


func _on_restart_button_pressed() -> void:
	_clearBoard()
	_setInitialData()
	_clearWinnerText()
