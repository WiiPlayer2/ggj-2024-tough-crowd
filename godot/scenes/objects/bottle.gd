extends Sprite2D

signal hit_tim

@export var bottle_speed: float = 120;

var tim_global_position: Vector2
var is_hidding: bool

# Called when the node enters the scene tree for the first time.
func _ready():
    tim_global_position = get_node("/root/IngameScene/Stage/Tim/ThrowPoint").global_position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    var t = create_tween().set_parallel()
    t.tween_property(self, "global_position", tim_global_position, 3.0)
    t.tween_property(self, "rotation_degrees", rotation_degrees + 270, 3.0)
    t.tween_callback(remove_bottle).set_delay(3.05)

func _on_bottle_area_entered(area):
    is_hidding = true

func _on_bottle_area_exited(area):
    is_hidding = false

func _on_growth_timer_timeout():
    var t = create_tween()
    t.tween_property(self, "scale", self.scale + Vector2(0.01, 0.01), 0.02)

func remove_bottle():
    if is_hidding:
        print("Ouch")
        Signals.hit_tim.emit()
    queue_free()
