extends Node2D
class_name Tile

@export var default_revealed_texture : Texture2D

@onready var sprite_unknown : Sprite2D = $SprUnknownTile
@onready var sprite_revealed : Sprite2D = $SprReveleadTile

func set_revealed_texture(texture : Texture2D) -> void:
	$SprReveleadTile.texture = texture
	pass

func get_sprite_dim() -> float:
	var spr : Sprite2D = $SprUnknownTile
	return spr.get_rect().size.x
	
# Called when the node enters the scene tree for the first time.
func _ready():
	sprite_revealed.texture = default_revealed_texture
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
