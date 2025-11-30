extends Node

signal highlight_changed(is_active : bool)
signal anihandler(is_active:bool)
var player : Player

var time_freeze :bool = false

var just_unfreezed : bool = false
var cutscene : bool = false

func toggle_freeze():
	time_freeze = !time_freeze
	just_unfreezed = true
	highlight_changed.emit(time_freeze)
	anihandler.emit(time_freeze)
#new
