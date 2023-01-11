Scriptname WCIQuestAliasPlayerScript extends ReferenceAlias

Event OnLocationChange(Location akOldLoc, Location akNewLoc)
	(GetOwningQuest() as WCIQuestScript).UpdateLocation(akOldLoc, akNewLoc)
EndEvent

Event OnSit(ObjectReference akFurniture)
	(GetOwningQuest() as WCIQuestScript).CheckSitCondition()
EndEvent