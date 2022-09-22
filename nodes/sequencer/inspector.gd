# Arrow
# Game Narrative Design Tool
# Mor. H. Golkar

# Sequencer Node Type Inspector
extends ScrollContainer

onready var Main = get_tree().get_root().get_child(0)

const DEFAULT_NODE_DATA = {
	"slots": SequencerSharedClass.SEQUENCER_MINIMUM_ACCEPTABLE_OUT_SLOTS
}

var _OPEN_NODE_ID
var _OPEN_NODE

var This = self

onready var Slots = get_node("./Sequencer/Slots")

func _ready() -> void:
	Slots.set_max(SequencerSharedClass.SEQUENCER_MAXIMUM_ACCEPTABLE_OUT_SLOTS)
	Slots.set_min(SequencerSharedClass.SEQUENCER_MINIMUM_ACCEPTABLE_OUT_SLOTS)
	# register_connections()
	pass

#func register_connections() -> void:
#	# e.g. SOME_CHILD.connect("the_signal", self, "the_handler_on_self", [], CONNECT_DEFERRED)
#	pass

func _update_parameters(node_id:int, node:Dictionary) -> void:
	# first cache the node
	_OPEN_NODE_ID = node_id
	_OPEN_NODE = node
	# ... then update parameters
	if node.has("data") && node.data is Dictionary:
		if node.data.has("slots") && node.data.slots is int:
			Slots.set_value(node.data.slots)
		else:
			Slots.set_value(DEFAULT_NODE_DATA.slots)
	pass

func _read_parameters() -> Dictionary:
	var parameters = {
		"slots": int( Slots.get_value() )
	}
	return parameters

func _create_new(new_node_id:int = -1) -> Dictionary:
	var data = DEFAULT_NODE_DATA.duplicate(true)
	return data
