extends StaticBody2D

@export var item_title: String = "Untitled Asset"
@export var item_type: String = "Prop"
@export_multiline var item_notes: String = "No notes added yet."

func get_display_data() -> Dictionary:
	return {
		"title": item_title,
		"type": item_type,
		"notes": item_notes
	}
