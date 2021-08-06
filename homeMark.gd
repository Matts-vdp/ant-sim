extends Area2D

var strength = 1
export var removeSpeed = 0.2
var type
var id

func _init():
    type = "homeM"

func _process(delta):
    strength -= removeSpeed * delta
    modulate.a = strength
    if strength <= 0:
        queue_free()
