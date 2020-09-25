extends Actor

func _ready():
	set_physics_process(false)
	velocity.x = -speed.x

func _physics_process(delta):
	if is_on_wall():
		velocity.x *= -1
		
	velocity.y = gravity * delta 
	velocity.y = move_and_slide(velocity, floor_normal).y
