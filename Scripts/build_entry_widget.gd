extends PanelContainer

#=== Class Variables ===
@onready var BuildNameNode = get_node("MarginContainer/HBox_EntryContent/Text_BuildName") as RichTextLabel

var EntryData : BuildEntryData

func _ready():
	pass


func _process(_delta):
	BuildNameNode.text = EntryData.BuildName


func SetData(InBuildEntryData : BuildEntryData):
	EntryData = InBuildEntryData


func _on_button_launch_pressed():
	#print(EntryData.ToString())
	if(OS.create_process(EntryData.ExecPath, EntryData.ExecArgs.rsplit(" ")) < 0):
		printerr("Failed to execute command!")
