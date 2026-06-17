extends CenterContainer

@onready var task_title: RichTextLabel = %TaskTitle
var task_to_delete: Node = null

signal task_deletion_confirmed(task: Node)

# Get task info and set labels
func set_task(task: Node):
	task_to_delete = task
	task_title.text = task.get_text()

func _on_cancel_button_pressed() -> void:
	queue_free()

# Signal up task deletion confirmed
func _on_confirm_button_pressed() -> void:
	emit_signal("task_deletion_confirmed", task_to_delete)
	queue_free()
