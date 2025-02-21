extends CanvasLayer

@onready var healthbar = $TextureProgressBar  # Adjust if needed

# Function to update the health bar
func update_health(value):
	healthbar.value = value
