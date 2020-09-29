extends Light2D

export var pulseDuration: = 1.0
onready var light: = get_node(".")
var increasing: = false
var pulseReduce: = false

func _ready():
	light.energy = 0.0
	_pulse()

func _physics_process(delta):
	if !increasing:
		return

	if light.energy <= 1 and !pulseReduce:
		light.energy += 0.2
	else:
		pulseReduce = true
		light.energy -= 0.2
	
	if light.energy <= 0 and pulseReduce:
		pulseReduce = false
		_pulse()
	
func _pulse():
	increasing = false
	yield(get_tree().create_timer(pulseDuration), "timeout")
	increasing = true

