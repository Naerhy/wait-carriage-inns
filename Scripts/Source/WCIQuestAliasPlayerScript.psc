Scriptname WCIQuestAliasPlayerScript extends ReferenceAlias

Event OnLocationChange(Location oldLoc, Location newLoc)
	(GetOwningQuest() as WCIQuestScript).UpdateLocation(oldLoc)
EndEvent

Event OnSit(ObjectReference furniture)
	(GetOwningQuest() as WCIQuestScript).CheckSitCondition()
EndEvent