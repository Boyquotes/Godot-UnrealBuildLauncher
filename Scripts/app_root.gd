extends Control


# Jira Backlog:
#	1. Edit/Save/Load launch configs
#	2. Group launch configs by category
#	3. Buttons to add/remove launch configs
#	4. Be able to bunch launch configs together into a "Recipe", so that you can launch a sequence like:
#		- Build Platform X script
#		- Launch Cook-on-the-fly
#		- Wait X seconds
#		- Launch game instance 1
#		- Launch game instance 2


class BuildConfigFileData:
	var version : String
	var buildConfigs = []


const BuildCategoryWidget = preload("res://Scenes/build_category_widget.tscn")
const ConfigFilePath = "C:\\Users\\jcmailhot\\MyFiles\\UnrealBuildLauncher_config.json"


@onready var BuildEntriesContainer = get_node("App_Background/VBox_AppContent/MarginContainer/ScrollContainer/VBox_MainContent/VBox_BuildEntries")


#=== Class Functions ===
func _ready():
	# Clear placeholder widgets
	# Remove placeholder widgets
	for ChildNode in BuildEntriesContainer.get_children():
		BuildEntriesContainer.remove_child(ChildNode)
		ChildNode.queue_free()
	
	# Load build configs
	var BuildEntries = LoadBuildConfigs()
	
	# Populate Categories
	var CategoryWidgets = {}
	for BuildEntry in BuildEntries:
		var Category: String = BuildEntry["BuildCategory"]
		if(!Category.is_empty() && !CategoryWidgets.has(Category)):
			CategoryWidgets[Category] = BuildCategoryWidget.instantiate()
			CategoryWidgets[Category].SetData(Category)
			BuildEntriesContainer.add_child(CategoryWidgets[Category])
	
	# Populate Widgets
	for BuildEntry in BuildEntries:
		var Category: String = BuildEntry["BuildCategory"]
		if(!Category.is_empty() && CategoryWidgets.has(Category)):
			CategoryWidgets[Category].AddEntryWidget(BuildEntry)


func LoadBuildConfigs():
	var OutBuildEntries = []
	
	# Read config file
	var BuildConfigsFile = FileAccess.open(ConfigFilePath, FileAccess.READ)
	var FileContent = BuildConfigsFile.get_as_text()
	BuildConfigsFile = null
	
	# Parse into JSON
	var ParsedFile = JSON.parse_string(FileContent)
	var ParsedBuildConfigs = ParsedFile["buildConfigs"]
	if(ParsedBuildConfigs == null):
		return OutBuildEntries
	
	# Convert JSON into data
	for ParsedEntry in ParsedBuildConfigs:
		var BuildEntry : BuildEntryData = BuildEntryData.new("")
		BuildEntry.BuildName = ParsedEntry["BuildName"] if ParsedEntry["BuildName"] else ""
		BuildEntry.BuildCategory = ParsedEntry["BuildCategory"] if ParsedEntry["BuildCategory"] else ""
		BuildEntry.ExecPath = ParsedEntry["ExecPath"] if ParsedEntry["ExecPath"] else ""
		BuildEntry.ExecArgs = ParsedEntry["ExecArgs"] if ParsedEntry["ExecArgs"] else ""
		OutBuildEntries.append(BuildEntry)
	
	return OutBuildEntries
