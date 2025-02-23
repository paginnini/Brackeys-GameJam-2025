extends CharacterBody2D

## Speed in pixels per second.
@export_range(0, 1000) var speed := 300

var array_of_itens = []
var item_in_hand

func _physics_process(_delta: float) -> void:
	get_player_input()
	move_and_slide()
	if array_of_itens:
		array_of_itens[0].get_highlighted()

func get_player_input() -> void:
	var vector := Input.get_vector("left", "right", "up", "down")
	velocity = vector * speed
	if Input.is_action_just_pressed("space_bar"):
		handle_item_change()
		

func handle_item_change() -> void:
	if array_of_itens:
		if item_in_hand:
			item_in_hand.position = position
			item_in_hand.dropped_down()
			array_of_itens.append(item_in_hand)
		item_in_hand = array_of_itens[0]
		array_of_itens[0].picked_up(self)
		array_of_itens.remove_at(0)
	elif item_in_hand:
		item_in_hand.position = position
		item_in_hand.dropped_down()
		array_of_itens.append(item_in_hand)
		item_in_hand = null

func _on_area_2d_area_entered(area: Area2D) -> void:
	print(area.get_class())
	if area is Item:
		print("item entered in range")
		array_of_itens.append(area)
		print(array_of_itens)


func _on_area_2d_area_exited(area: Area2D) -> void:
	if area is Item:
		print("item out of range")
		for node_index in array_of_itens.size():
			if array_of_itens[node_index] == area:
				array_of_itens[node_index].get_unhighlighted()
				array_of_itens.remove_at(node_index)
				break
		print(array_of_itens)
