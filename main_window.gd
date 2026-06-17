extends Control

# Task Dialogs
const TASK_CREATE_DIALOG = preload("uid://b04adfi2qua3f")
const TASK_DELETION_DIALOG = preload("uid://f87etx327kjr")
# Interface Sections
@onready var task_section: PanelContainer = %TaskSection

# Handle prompting and creating task
func _on_task_section_call_task_creation() -> void:
	var task_create_dialog = TASK_CREATE_DIALOG.instantiate()
	add_child(task_create_dialog)
	task_create_dialog.task_creation_completed.connect(_call_task_creation)

# Pass down task creation call
func _call_task_creation(title: String) -> void:
	task_section.create_task(title)

# Handle prompting and deleting task
func _on_task_section_call_task_deletion(task: Node) -> void:
	var task_deletion_dialog = TASK_DELETION_DIALOG.instantiate()
	add_child(task_deletion_dialog)
	task_deletion_dialog.set_task(task)
	task_deletion_dialog.task_deletion_confirmed.connect(_call_task_deletion)

# Delete task
func _call_task_deletion(task: Node):
	task.queue_free()
