Scriptname WCIQuestScript extends Quest conditional

GlobalVariable property carriageCost auto
GlobalVariable property carriageCostSmall auto
GlobalVariable property carriageCostHouse auto
ImageSpaceModifier property fadeToBlackHoldImod auto
MiscObject property gold auto
ObjectReference property carriageDriver auto
ObjectReference[] property fastTravelMarkers auto

bool waitForDriver conditional
Location waitLocation

Event OnInit()
	carriageCostHouse.SetValue(carriageCost.GetValue() + carriageCostSmall.GetValue())
	waitForDriver = false
	waitLocation = none
EndEvent

Event OnUpdate()
	Debug.Notification("OnUpdate.")
	if (Game.GetPlayer().GetCurrentLocation() != waitLocation)
		Debug.Notification("Resetting the quest.")
		ResetQuest()
	endIf
EndEvent

Function RequestDriver()
	waitForDriver = true
	waitLocation = Game.GetPlayer().GetCurrentLocation()
EndFunction

Function CheckSitCondition()
	if (waitForDriver && Game.GetPlayer().GetCurrentLocation() == waitLocation)
		WaitForCarriageDriver()
	endIf
EndFunction

Function WaitForCarriageDriver()
	if (carriageDriver.IsDisabled())
		carriageDriver.MoveTo(Game.GetPlayer())
		Game.DisablePlayerControls(true, true, true, true, true, true, true, true)
		fadeToBlackHoldImod.ApplyCrossFade(1.5)
		Utility.Wait(1.5)
		carriageDriver.Enable()
		Debug.Notification("A carriage driver has entered the inn.")
		Utility.Wait(1.5)
		ImageSpaceModifier.RemoveCrossFade(1.5)
		Game.EnablePlayerControls()
	endIf
EndFunction

Function Travel(int index)
	Actor player = Game.GetPlayer()
	float deltaWeight = player.GetActorValue("CarryWeight") - player.GetActorValue("InventoryWeight")

	if (deltaWeight < 0)
		player.ModActorValue("CarryWeight", -deltaWeight)
	endIf
	Game.FastTravel(fastTravelMarkers[index])
	if (deltaWeight < 0)
		player.ModActorValue("CarryWeight", deltaWeight)
	endIf
	if (index < 5)
		player.RemoveItem(gold, carriageCost.GetValue() as int)
	elseif (index < 18)
		player.RemoveItem(gold, carriageCostSmall.GetValue() as int)
	else
		player.RemoveItem(gold, carriageCostHouse.GetValue() as int)
	endIf
EndFunction

Function UpdateLocation(Location oldLoc)
	if (waitForDriver && oldLoc == waitLocation)
		Debug.Notification("Registering for update.")
		RegisterForSingleUpdate(20.0)
	endIf
EndFunction

Function ResetQuest()
	if (carriageDriver.IsEnabled())
		carriageDriver.Disable()
	endIf
	waitForDriver = false
	waitLocation = None
EndFunction