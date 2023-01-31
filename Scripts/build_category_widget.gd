extends VBoxContainer

const BuildEntryWidget = preload("res://Scenes/build_entry_widget.tscn")

@onready var TextTitle = get_node("Text_Category") as RichTextLabel
@onready var BuildEntriesContainer = get_node("VBox_BuildEntries") as VBoxContainer
var CategoryName:String


func _ready():
	# Remove placeholder widgets
	for ChildNode in BuildEntriesContainer.get_children():
		BuildEntriesContainer.remove_child(ChildNode)
		ChildNode.queue_free()


func _process(_delta):
	TextTitle.text = CategoryName


func SetData(InCategoryName:String):
	CategoryName = InCategoryName


func AddEntryWidget(EntryData : BuildEntryData):
	var widget = BuildEntryWidget.instantiate()
	widget.SetData(EntryData)
	BuildEntriesContainer.add_child(widget)
