extends CanvasLayer

@onready var prompt_label: Label = %PromptLabel
@onready var title_label: Label = %TitleLabel
@onready var type_label: Label = %TypeLabel
@onready var notes_label: Label = %NotesLabel
@onready var wave_label: Label = %WaveLabel
@onready var health_label: Label = %HealthLabel
@onready var game_over_label: Label = %GameOverLabel
@onready var scrap_label: Label = %ScrapLabel
@onready var status_label: Label = %StatusLabel

var _status_time_remaining: float = 0.0

func _ready() -> void:
	hide_prompt()
	show_item_details({})
	update_wave_status(0, 0)
	update_health(0, 0)
	update_scrap(0)
	show_status("")
	show_game_over(false)

func _process(delta: float) -> void:
	if _status_time_remaining <= 0.0:
		return

	_status_time_remaining = maxf(_status_time_remaining - delta, 0.0)
	if _status_time_remaining == 0.0:
		status_label.text = ""

func show_prompt(item) -> void:
	if item == null:
		hide_prompt()
		return

	var data: Dictionary = item.get_display_data()
	prompt_label.text = "E: inspect %s" % data.get("title", "asset")
	prompt_label.visible = true

func hide_prompt() -> void:
	prompt_label.visible = false

func show_item_details(data: Dictionary) -> void:
	if data.is_empty():
		title_label.text = "No asset selected"
		type_label.text = "Move: WASD / Arrows    Shoot: Space"
		notes_label.text = ""
		return

	title_label.text = data.get("title", "Untitled Asset")
	type_label.text = "Type: %s" % data.get("type", "Unknown")
	notes_label.text = data.get("notes", "")

func show_upgrade_station(scrap: int, costs: Dictionary) -> void:
	title_label.text = "Room Control Terminal"
	type_label.text = "Scrap: %d" % scrap
	notes_label.text = "1 Weapon charge (%d)\n2 Faster blaster (%d)\n3 Hull plating (%d)" % [
		costs.get("weapon", 0),
		costs.get("fire_rate", 0),
		costs.get("hull", 0),
	]

func update_wave_status(wave_number: int, enemies_remaining: int) -> void:
	if wave_number <= 0:
		wave_label.text = "Wave --    Drones --"
		return

	wave_label.text = "Wave %d    Drones %d" % [wave_number, enemies_remaining]

func update_health(current_health: int, max_health: int) -> void:
	if max_health <= 0:
		health_label.text = "Hull --/--"
		return

	health_label.text = "Hull %d/%d" % [current_health, max_health]

func update_scrap(scrap: int) -> void:
	scrap_label.text = "Scrap %d" % scrap

func show_status(message: String, duration: float = 1.2) -> void:
	status_label.text = message
	_status_time_remaining = duration if not message.is_empty() else 0.0

func show_game_over(should_show: bool) -> void:
	game_over_label.visible = should_show
