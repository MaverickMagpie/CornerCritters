extends MarginContainer

@onready var task_text: RichTextLabel = %TaskText
@onready var task_checkbox: CheckBox = %TaskCheckbox
@onready var delete_section: MarginContainer = $TaskSection/TaskHBox/DeleteSection

# Emitted when task delete button is pressed
signal call_task_deletion(task: Node)

func set_text(text):
	task_text.text = text

func get_text():
	return task_text.text

# Toggles visibility mode between showing checkbox or delete button
func toggle_visibility_mode() -> void:
	task_checkbox.visible = !task_checkbox.visible
	delete_section.visible = !delete_section.visible

func _on_delete_button_pressed() -> void:
	emit_signal("call_task_deletion", self)
