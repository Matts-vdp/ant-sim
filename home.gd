extends Area2D

var antres = preload("res://ant.tscn") 
export var startingAnts = 2
var food = 0
var cnt = 0
var type = "home"
onready var foodCnt = $foodcnt
var ants = 0

func _init():
    randomize()

func _ready():
    for i in range(startingAnts):
        spawnAnt()

func spawnAnt():
    ants += 1
    var ins = antres.instance()
    var angle = rand_range(0,2*PI)
    ins.position = position
    ins.rotation = angle
    ins.id = cnt
    ins.targetAngle = angle
    cnt += 1
    call_deferred("add_child", ins)

func spawnAnts():
    while ants < startingAnts:
        spawnAnt()

func _on_home_body_entered(body):
    if body != null:
        var i = body.depositFood()
        food += i
        ants -= i
        spawnAnts()
        foodCnt.text = str(food)
    
