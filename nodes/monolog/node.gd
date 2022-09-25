# Arrow
# Game Narrative Design Tool
# Mor. H. Golkar

# Monolog Node Type
extends GraphNode

onready var Main = get_tree().get_root().get_child(0)

var Utils = Helpers.Utils

const ANONYMOUS_CHARACTER = MonologSharedClass.ANONYMOUS_CHARACTER
const DEFAULT_NODE_DATA = MonologSharedClass.DEFAULT_NODE_DATA

var _node_id
var _node_resource

var This = self

onready var AutoPlay = get_node("./Rows/Header/AutoPlay")
onready var ClearPage = get_node("./Rows/Header/ClearPage")
# onready var CharacterProfile  = get_node("./Rows/CharacterProfile")
onready var CharacterProfileName  = get_node("./Rows/CharacterProfile/Name")
onready var CharacterProfileColor = get_node("./Rows/CharacterProfile/Color")
onready var Brief = get_node("./Rows/Brief")

#func _ready() -> void:
#	register_connections()
#	pass

#func register_connections() -> void:
#	# e.g. SOME_CHILD.connect("the_signal", self, "the_handler_on_self", [], CONNECT_DEFERRED)
#	pass

func update_character(profile:Dictionary) -> void:
	if profile.has("name") && (profile.name is String):
		CharacterProfileName.set("text", profile.name)
	if profile.has("color") && (profile.color is String):
		CharacterProfileColor.set("color", Utils.rgba_hex_to_color(profile.color))
	pass

func set_character_anonymous() -> void:
	update_character( ANONYMOUS_CHARACTER )
	pass

func _update_node(data:Dictionary) -> void:
	# Character
	if data.has("character") && (data.character is int) && (data.character >= 0):
		var the_character_profile = Main.Mind.lookup_resource(data.character, "characters")
		if the_character_profile != null :
			update_character( the_character_profile )
		else:
			printerr("Use of non-existent character UID in the node data: ", data)
	else:
		set_character_anonymous()
	# Line Brief
	var brief_length = int( data.brief if data.has("brief") else DEFAULT_NODE_DATA.brief)
	var monolog = data.monolog if data.has("monolog") && data.monolog is String else DEFAULT_NODE_DATA.monolog
	Brief.set_bbcode( monolog.substr(0, brief_length) )
	Brief.set_visible( brief_length != 0 )
	# Auto-play indicator
	AutoPlay.set_visible( data.auto if (data.has("auto") && data.auto is bool) else DEFAULT_NODE_DATA.auto)
	# Print on clear page indicator
	ClearPage.set_visible( data.clear if (data.has("clear") && data.clear is bool) else DEFAULT_NODE_DATA.clear)
	pass
