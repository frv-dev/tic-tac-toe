extends Node2D
class_name BoardButton


signal click

const _boardPositions := preload('res://src/scripts/enums/board_positions.gd').BoardPositions

@export var boardPosition: _boardPositions

var isPressed := false


func _on_touch_screen_button_pressed() -> void:
	if not isPressed:
		emit_signal('click')
		isPressed = true
