# Arrow
# Game Narrative Design Tool
# Mor. H. Golkar

# Content Node Type
extends GraphNode

onready var Main = get_tree().get_root().get_child(0)
onready var Mind = Main.Mind

var Utils = Helpers.Utils

const TITLE_UNSET_MESSAGE = "Untitled"
const HIDE_UNSET_TITLE = true

const BRIEF_UNSET_MESSAGE = ""

var _node_id
var _node_resource

var This = self

onready var Title = get_node("./VBoxContainer/Title")
onready var Brief = get_node("./VBoxContainer/Brief")
onready var AutoPlay = get_node("./VBoxContainer/Header/AutoPlay")
onready var ClearPage = get_node("./VBoxContainer/Header/ClearPage")

#func _ready() -> void:
#	register_connections()
#	pass

#func register_connections() -> void:
#	# e.g. SOME_CHILD.connect("the_signal", self, "the_handler_on_self", [], CONNECT_DEFERRED)
#	pass

func _update_node(data:Dictionary) -> void:
	# Title
	var title = data.title if data.has("title") && data.title is String && data.title.length() > 0 else null
	Title.set_bbcode(title if title is String else TITLE_UNSET_MESSAGE)
	Title.set_visible(title is String || (! HIDE_UNSET_TITLE ))
	# Brief
	Brief.set_visible(false)
	var brief = null;
	if data.has("brief"):
		var brief_length = int(data.brief)
		# Legacy brief (textual, which is not really a number)
		if data.brief is String && data.brief != String(brief_length):
			brief = data.brief
		# Normal brief (numeral length)
		elif data.has("content") && data.content is String:
			brief = data.content.substr(0, brief_length)
		else:
			brief = BRIEF_UNSET_MESSAGE
		if brief is String && brief.length() > 0:
			Brief.set_bbcode(brief)
			Brief.set_visible(true)
	# Auto-play indicator
	AutoPlay.set_visible( data.has("auto") && data.auto == true)
	# Print on clear page indicator
	ClearPage.set_visible( data.has("clear") && data.clear == true)
	pass
