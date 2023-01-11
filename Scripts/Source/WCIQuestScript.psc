Scriptname WCIQuestScript extends Quest conditional

GlobalVariable property CarriageCost auto
GlobalVariable property CarriageCostSmall auto
ImageSpaceModifier property FadeToBlackHoldImod auto
Keyword property LocTypeInn auto
MiscObject property Gold001 auto
ObjectReference property WCICarriageDriver auto

ObjectReference[] property FastTravelMarkers auto

Bool WaitingForDriver conditional
Location CurrentPlayerInn

Event OnInit()
	WaitingForDriver = false
	CurrentPlayerInn = Game.GetPlayer().GetCurrentLocation()
EndEvent

Event OnUpdate()
	Location CurrentLoc = Game.GetPlayer().GetCurrentLocation()

	Debug.Notification("OnUpdate.")
	if (CurrentLoc != CurrentPlayerInn)
		Debug.Notification("Resetting the quest.")
		ResetQuest()
		if (CurrentLoc.HasKeyword(LocTypeInn))
			CurrentPlayerInn = CurrentLoc
		endIf
	endIf
EndEvent

Function UpdateLocation(Location OldLoc, Location NewLoc)
	if (!WaitingForDriver && NewLoc.HasKeyword(LocTypeInn))
		Debug.Notification("CurrentPlayerInn has been updated.")
		CurrentPlayerInn = NewLoc
	endIf
	if (WaitingForDriver && OldLoc == CurrentPlayerInn)
		Debug.Notification("Registering for update.")
		RegisterForSingleUpdate(20.0)
	endIf
EndFunction

Function SetWaitingForDriver(Bool WaitingStatus)
	WaitingForDriver = WaitingStatus
EndFunction

Function CheckSitCondition()
	if (WaitingForDriver && Game.GetPlayer().GetCurrentLocation() == CurrentPlayerInn)
		WaitForCarriageDriver()
	endIf
EndFunction

Function WaitForCarriageDriver()
	if (WCICarriageDriver.IsDisabled())
		WCICarriageDriver.MoveTo(Game.GetPlayer())
		Game.DisablePlayerControls(true, true, true, true, true, true, true, true)
		FadeToBlackHoldImod.ApplyCrossFade(1.5)
		Utility.Wait(1.5)
		WCICarriageDriver.Enable()
		Debug.Notification("A carriage driver has entered the inn.")
		Utility.Wait(1.5)
		ImageSpaceModifier.RemoveCrossFade(1.5)
		Game.EnablePlayerControls()
	endIf
EndFunction

Function Travel(Int Index)
	Game.FastTravel(FastTravelMarkers[Index])
	if (Index < 5)
		Game.GetPlayer().RemoveItem(Gold001, CarriageCost.GetValue() as int)
	else
		Game.GetPlayer().RemoveItem(Gold001, CarriageCostSmall.GetValue() as int)
	endIf
EndFunction

Function ResetQuest()
	if (WCICarriageDriver.IsEnabled())
		WCICarriageDriver.Disable()
	endIf
	WaitingForDriver = false
EndFunction