extends CharacterBody3D

@export var speed: float = 2.0
@export var player: Node3D  
@onready var nav_agent: NavigationAgent3D = $NavigationAgent3D

var gravity: float = 9.8  # Adjust as needed
var navigation_ready: bool = false

func _ready():
	await get_tree().process_frame  # Wait at least one frame for navmesh to sync
	navigation_ready = true

func _physics_process(delta):
	if not navigation_ready or not player:
		return

	# Apply gravity manually
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Get navigation path
	nav_agent.target_position = player.global_transform.origin
	var next_position = nav_agent.get_next_path_position()

	# Move towards the next position
	var direction = (next_position - global_transform.origin).normalized()
	if is_on_floor():
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		velocity.x = lerp(velocity.x, direction.x * speed, delta * 3.0)
		velocity.z = lerp(velocity.z, direction.z * speed, delta * 3.0)

	move_and_slide()
