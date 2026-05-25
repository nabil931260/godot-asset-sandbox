extends CanvasLayer

@onready var prompt_label: Label = %PromptLabel
@onready var title_label: Label = %TitleLabel
@onready var type_label: Label = %TypeLabel
@onready var notes_label: Label = %NotesLabel

func _ready() -> void:
	hide_prompt()
	show_item_details({})

func show_prompt(item) -> void:
	if item == null:
		hide_prompt()
		return

	var data: Dictionary = item.get_display_data()
	prompt_label.text = "Press E to inspect %s" % data.get("title", "asset")
	prompt_label.visible = true

func hide_prompt() -> void:
	prompt_label.visible = false

func show_item_details(data: Dictionary) -> void:
	if data.is_empty():
		title_label.text = "No asset selected"
		type_label.text = "Move near an object and press E."
		notes_label.text = ""
		return

	title_label.text = data.get("title", "Untitled Asset")
	type_label.text = "Type: %s" % data.get("type", "Unknown")
	notes_label.text = data.get("notes", "")
