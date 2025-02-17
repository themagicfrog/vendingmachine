extends Node

@onready var oxygen_bar: ProgressBar = $"../UI/Oxygen/OxygenBar"
@onready var hearts_container = $"../UI/Hearts/HBoxContainer"
@onready var hearts: Array[Node] = []
@onready var timer: Timer = $"../UI/Timer"

const OXYGEN_REFILL = 14 
var oxygen = 100
var lives = 5

func _ready():
	for heart in hearts_container.get_children():
		hearts.append(heart)
	
	update_hearts()

	oxygen_bar.min_value = 0
	oxygen_bar.max_value = 100
	oxygen_bar.step = 1
	oxygen_bar.value = oxygen
	
	timer.start()
	timer.connect("timeout", Callable(self, "_on_timer_timeout"))

func update_hearts():
	for h in hearts.size():
		if h < lives:
			hearts[h].show()
		else:
			hearts[h].hide()
	if lives == 0:
		get_tree().reload_current_scene()

func lose_life():
	lives -= 1
	update_hearts()

func addOxygen():
	oxygen = min(oxygen + OXYGEN_REFILL, 100)
	oxygen_bar.value = oxygen
	print(oxygen)

func decreaseOxygen():
	if oxygen > 0:
		oxygen -= 0
	oxygen_bar.value = oxygen
	if oxygen <= 0:
		lose_life()
	
func _on_timer_timeout():
	if oxygen > 0:
		oxygen -= 2
	oxygen_bar.value = oxygen
	if oxygen <= 0:
		lose_life()
	
