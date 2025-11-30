extends Node

signal highlight_changed(is_active : bool)
var kills : int = 0

var player : Player

var time_freeze :bool = false

var just_unfreezed : bool = false
var cutscene : bool = false

func toggle_freeze():
	time_freeze = !time_freeze
	just_unfreezed = true
	highlight_changed.emit(time_freeze)
#new
