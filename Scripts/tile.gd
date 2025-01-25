extends Node2D
class_name Tile

@export var default_revealed_texture : Texture2D
#@export var default_unknown_texture : Texture2D

@onready var sprite_unknown : Sprite2D = $SprUnknownTile
@onready var sprite_revealed : Sprite2D = $SprRevealedTile

@onready var tile_unknown_texture : Texture2D = sprite_unknown.texture

var revealed : bool : 
	get: return not sprite_unknown.visible
	
var flagged = false

func set_revealed_texture(texture : Texture2D) -> void:
	$SprRevealedTile.texture = texture
	pass

func get_sprite_dim() -> float:
	var spr : Sprite2D = $SprUnknownTile
	return spr.get_rect().size.x

## reveals tile if not already revealed 
func reveal():
	if sprite_unknown.visible:
		sprite_unknown.visible = false
		
# TODO : is it correct to be passing in flag texture every time a flag is toggled? it will never
# change over course of a game 
func toggle_flag(flag_texture : Texture2D):
	if not revealed:
		if not flagged:
			sprite_unknown.texture = flag_texture
			flagged = true
		else:
			sprite_unknown.texture = tile_unknown_texture
			flagged = false
		 

# Called when the node enters the scene tree for the first time.
func _ready():
	sprite_revealed.texture = default_revealed_texture
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
