# Highlightable.gd
extends Node

# Tutaj przeciągnij w inspektorze swój materiał z Kroku 2
@export var outline_material: Material 

# Referencja do obiektu wizualnego (MeshInstance3D lub Sprite2D)
@onready var parent_visual = get_parent() 

func _ready():
	# 1. Dodajemy obiekt do grupy (system tagowania)
	parent_visual.add_to_group("interactable")
	
	# 2. Podłączamy się do globalnego sygnału
	Global.highlight_changed.connect(_on_global_highlight_changed)
	
	# 3. Ustawiamy stan początkowy (na wypadek gdyby gra startowała z włączonym trybem)
	_apply_outline(Global.time_freeze)

func _on_global_highlight_changed(is_active: bool):
	_apply_outline(is_active)

func _apply_outline(active: bool):
	if active:
		# Dla 3D używamy material_overlay - to klucz do sukcesu!
		# Dzięki temu nie nadpisujemy oryginalnej tekstury obiektu.
		if parent_visual is MeshInstance3D:
			parent_visual.material_overlay = outline_material
		# Dla 2D (Sprite) zwykle podmienia się material
		elif parent_visual is Sprite2D:
			parent_visual.material = outline_material
			
	else:
		# Wyłączamy obrys
		if parent_visual is MeshInstance3D:
			parent_visual.material_overlay = null
		elif parent_visual is Sprite2D:
			parent_visual.material = null
