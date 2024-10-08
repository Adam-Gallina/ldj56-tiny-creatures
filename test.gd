extends Node3D

@onready var path_gen = get_node('Pathing')
@onready var attacks = get_node('AttackSpawner')
@onready var debris = get_node('DebrisSpawner')

func _ready():
    var s = path_gen.generate_new_segment(Vector3.ZERO, Vector3.MODEL_FRONT)
    #s.activate_particles()
    for i in range(2):
        path_gen.generate_new_segment(s.end_pos, s.end_dir)

    # Would normally use player pos
    var sfollow : PathFollow3D = s.center.get_node('PathFollow3D')
    sfollow.progress_ratio = .1
    var a = attacks.get_attack(s, sfollow, path_gen.PathSegmentLength/2)

    a.tesselate_path()

    a.start_attack()


    var d = debris.generate_debris_field(40, 50)
    d.global_position = Vector3(0, 0, 100)
    s.center.add_child(d)