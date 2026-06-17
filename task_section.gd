extends PanelContainer

# Task scene to create children
const TASK = preload("uid://dourdge8ytodo")
# Where to place task children
@onready var task_display: VBoxContainer = %TaskDisplayVBox

signal call_task_creation
signal call_task_deletion(task: Node)

# Add task to task display
func create_task(title: String):
	var new_task = TASK.instantiate()
	task_display.add_child(new_task)
	new_task.set_text(title)
	new_task.call_task_deletion.connect(_toss_call_task_deletion)

# Signal up prompt for task creation
func _on_create_task_button_pressed() -> void:
	emit_signal("call_task_creation")

# Signal up prompt for task deletion
func _toss_call_task_deletion(task: Node):
	emit_signal("call_task_deletion", task)

# Toggle between displaying checkboxes and delete buttons for tasks
func _on_edit_task_button_pressed() -> void:
	for task in task_display.get_children():
		task.toggle_visibility_mode()
