class_name Item
extends Area2D

enum ItemType {
	COG,
	REVOLVER,
	PIPE,
	COAL,
	BAG,
	LASSO,
}

@onready var polygon_2d: Polygon2D = $Polygon2D
@onready var sprite_2d: Sprite2D = $Sprite2D

@export var type := ItemType.COG

#var texture_cog = preload("res://sprites/cog.png")
#var texture_cog_hi = preload("res://sprites/cog_hi.png")
#var texture_revolver = preload("res://sprites/revolver.png")
#var texture_revolver_hi = preload("res://sprites/revolver_hi.png")

var texture_normal
var texture_highlight

var offset := Vector2(-10, 10)
var player :CharacterBody2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	match type:
		ItemType.COG:
			texture_normal = preload("res://sprites/cog.png")
			texture_highlight = preload("res://sprites/cog_hi.png")
		ItemType.REVOLVER:
			texture_normal = preload("res://sprites/revolver.png")
			texture_highlight = preload("res://sprites/revolver_hi.png")
		ItemType.PIPE:
			texture_normal = preload("res://sprites/cog.png")
		ItemType.COAL:
			texture_normal = preload("res://sprites/cog.png")
		ItemType.BAG:
			texture_normal = preload("res://sprites/cog.png")
		ItemType.LASSO:
			texture_normal = preload("res://sprites/cog.png")
	sprite_2d.texture = texture_normal


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if player:
		position = player.position + offset


func _on_body_entered(body: Node2D) -> void:
	print("In range")


func _on_body_exited(body: Node2D) -> void:
	print("out of range")
	

func get_highlighted() -> void:
	sprite_2d.texture = texture_highlight
	
func get_unhighlighted() -> void:
	sprite_2d.texture = texture_normal

func picked_up(player_node) -> void:
	print("item got picked up", player_node)
	player = player_node
	get_unhighlighted()

func dropped_down() -> void:
	player = null
	print("dropped down")
