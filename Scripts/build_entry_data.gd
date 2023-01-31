extends Node
class_name BuildEntryData

#=== Class Variables ===
var BuildName : String
var BuildCategory : String
var ExecPath : String
var ExecArgs : String

func _init(InBuildName, InBuildCategory = "", InExectPath = "", InExecArgs = ""):
	BuildName = InBuildName
	BuildCategory = InBuildCategory
	ExecPath = InExectPath
	ExecArgs = InExecArgs

func ToString():
	var OutputString = "\"%s\", \"%s\", \"%s\", \"%s\""
	return OutputString % [BuildName, BuildCategory, ExecPath, ExecArgs]
