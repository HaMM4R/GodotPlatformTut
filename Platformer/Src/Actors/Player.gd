extends Actor

export var stomp_impulse: = 1000.0

func _on_EnemyDetection_area_entered(area):
	velocity = CalcStompVelocity(velocity, stomp_impulse)
	
func _on_EnemyDetection_body_entered(body):
	queue_free()


func _physics_process(delta):
	var is_jump_interrupted:= Input.is_action_just_released("jump") and velocity.y < 0.0
	var dir: = Dir()
	
	velocity = Velocity(velocity, speed, dir, is_jump_interrupted)
	velocity = move_and_slide(velocity, floor_normal)

func Dir() -> Vector2:
	return Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		-1.0 if Input.is_action_just_pressed("jump") and is_on_floor() else 1.0
	)

func Velocity(linear_vel: Vector2, speed: Vector2, dir: Vector2, interrupt: bool) -> Vector2:
	var vel: = linear_vel

	vel.x = speed.x * dir.x
	vel.y += gravity * get_physics_process_delta_time()

	if dir.y == -1.0:
		vel.y = speed.y * dir.y

	if interrupt:
		vel.y = 0
		
	return vel

func CalcStompVelocity(linear_vel: Vector2, stomp: float) -> Vector2:
	var out: = linear_vel 
	out.y = -stomp
	return out

