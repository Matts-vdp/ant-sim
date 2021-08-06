extends KinematicBody2D

var homeMark = preload("res://markers/homeMark.tscn")
var foodMark = preload("res://markers/foodMark.tscn")
onready var timer = $Timer

export var speed = 100
export var randomwalkang = 0.015
export var arrivedAtFood = 100
export var placeTime = 1
export var rotationSpeed = 1
var hasFood = false
var Target = null
var lastMarker = null
var markers = []
var id
onready var targetAngle = rotation
var homeMarks = []
    
func _ready():
    timer.start(placeTime)

func _physics_process(delta):
    var v = Vector2(speed*delta,0)
    if Target == null:
        var angle = getMarkDir()
        rotateToAngle(angle)
    else:
        rotateToPoint(Target)
        if position.distance_squared_to(Target) < arrivedAtFood:
            Target = null
    rotator(delta)
    v = v.rotated(rotation)
    var vx = Vector2(v.x,0)
    var vy = Vector2(0,v.y)
    move(v, vx)
    move(v, vy)

func move(v, vec):
    var obj = move_and_collide(vec)
    if obj != null:
        if obj.collider.type == 'food' && !hasFood:
            takeFood(obj)
        elif obj.collider.type == "wall":
            var vecAbs = Vector2(abs(vec.x), abs(vec.y))
            v -= (v * vecAbs.normalized()) * 2
            rotation = v.angle()
            targetAngle = rotation
            move(v, v * vecAbs.normalized())
            

func getMarkDir():
    if markers.size() == 0:
        return targetAngle
    var sum = Vector2(0,0)
    for mark in markers:
        sum += mark.position
    sum /= markers.size()
    return sum.angle_to_point(position) 

func getRandomDir():
    var rang = randf() * randomwalkang
    rang = rang * (randi() % 7 - 3)
    return rang

func takeFood(obj):
    hasFood = true
    Target = null
    obj.collider.take()
    rotateToPoint(lastMarker)
    markers.clear()
    set_collision_mask_bit(2, false)
    
func depositFood():
    if !hasFood:
        return 0
    else:
        #for mark in homeMarks:
        #    if mark != null:
        #        mark.queue_free()
        queue_free()
        return 1
        
func moveFromWall():
    rotateToAngle(rotation + ((randi()%2)*2-1)*(PI/2))
    
func rotateToAngle(angle):
    targetAngle = angle

func rotateToPoint(point):
    rotateToAngle(point.angle_to_point(position))

func rotator(delta):
    rotation = targetAngle
    

func goTo(area):
    rotateToPoint(area.position)

func _on_Area2D_area_entered(area):
    if hasFood:
        if area.type == "home":
            Target = area.position
        elif area.type == "homeM":
            markers.append(area)
    else:
        if area.type == "foodMark":
            markers.append(area)
    

func _on_Area2D_body_entered(body):
    if !hasFood && Target==null && body.type == "food":
        Target = body.position


func _on_Timer_timeout():
    var ins
    if hasFood:
        ins = foodMark.instance()
        get_parent().add_child(ins)
    else:
        ins = homeMark.instance()
        get_parent().add_child(ins)
        homeMarks.append(ins)
    ins.position = position
    ins.id = id
    lastMarker = ins.position
    timer.start(placeTime)


func _on_Area2D_area_exited(area):
    markers.erase(area)
