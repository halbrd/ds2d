extends KinematicBody

export var team = 1
var team_colors = {
	1: preload("res://TeamOneBody.tres"),
	2: preload("res://TeamTwoBody.tres")
}

var path = []
var path_ind = 0
const move_speed = 12
onready var nav = get_parent()

func _ready():
	if team in team_colors:
		$Body.material_override = team_colors[team]

func move_to(target_pos):
	path = nav.get_simple_path(global_transform.origin, target_pos)
	path_ind = 0

func _physics_process(delta):
	if path_ind < path.size():
		var move_vec = (path[path_ind] - global_transform.origin)
		if move_vec.length() < 0.1:
			path_ind += 1
			if path_ind < path.size():
				look_at(path[path_ind], Vector3.UP)
		else:
			move_and_slide(move_vec.normalized() * move_speed, Vector3.UP)

func select():
	$SelectIndicator.show()

func deselect():
	$SelectIndicator.hide()
