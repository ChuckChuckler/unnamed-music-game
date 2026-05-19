extends AudioStreamPlayer

@onready var noteDetector = $"../NoteDetector"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	noteDetector.detect_note_started.connect(find_note)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
	
func find_note(e:NoteDetectEvent)->void:
	print_debug("note: ", e.note_full_name)
	
	
