extends CenterContainer

@onready var info_text: RichTextLabel = $TaskCreateSection/TaskCreateVBox/InfoText
@onready var task_title_edit: LineEdit = %TaskTitleEdit

signal task_creation_completed(text: String)

# Error text when no task title is entered
const ERROR_MESSAGE: String = "ERROR: Must enter a task title below."

func _ready() -> void:
	task_title_edit.call_deferred("grab_focus")

func _on_cancel_button_pressed() -> void:
	queue_free()

func _on_confirm_button_pressed() -> void:
	if task_title_edit.text.length() > 0:
		# Signal up task title created
		emit_signal("task_creation_completed", task_title_edit.text)
		queue_free()
	else:
		info_text.text = ERROR_MESSAGE

# Helper function that catches user pressing enter after typing task title
func _on_task_title_edit_text_submitted(_new_text: String) -> void:
	_on_confirm_button_pressed()
