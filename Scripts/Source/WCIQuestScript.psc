Scriptname WCIQuestScript extends Quest conditional

GlobalVariable property carriageCost auto
GlobalVariable property carriageCostSmall auto
GlobalVariable property carriageCostHouse auto
ImageSpaceModifier property fadeToBlackHoldImod auto
Keyword property locTypeInn auto
Location property tamrielLoc auto
Location[] property disabledLocations auto
MiscObject property gold auto
ObjectReference[] property carriageDrivers auto
ObjectReference[] property fastTravelMarkers auto

bool showInnkeeperDialogue conditional
bool waitForDriver conditional
int activeDriver
Location waitLocation

Event OnInit()
	carriageCostHouse.SetValue(carriageCost.GetValue() + carriageCostSmall.GetValue())
	showInnkeeperDialogue = IsAccurateInnLoc(Game.GetPlayer().GetCurrentLocation())
	activeDriver = -1
	waitForDriver = false
	waitLocation = none
EndEvent

Event OnUpdate()
	if (Game.GetPlayer().GetCurrentLocation() != waitLocation)
		ResetQuest()
	endIf
EndEvent

bool Function IsAccurateInnLoc(Location loc)
	if (loc.HasKeyword(locTypeInn) && tamrielLoc.IsChild(loc) && !IsDisabledLoc(loc))
		return true
	endIf
	return false
EndFunction

bool Function IsDisabledLoc(Location loc)
	int i = 0

	while (i < disabledLocations.Length)
		if (disabledLocations[i].IsChild(loc))
			return true
		endIf
		i += 1
	endWhile
	return false
EndFunction

Function RequestDriver()
	waitForDriver = true
	waitLocation = Game.GetPlayer().GetCurrentLocation()
	activeDriver = Utility.RandomInt(0, 2)
EndFunction

Function CheckSitCondition()
	if (waitForDriver && Game.GetPlayer().GetCurrentLocation() == waitLocation)
		WaitForCarriageDriver()
	endIf
EndFunction

Function WaitForCarriageDriver()
	if (carriageDrivers[activeDriver].IsDisabled())
		carriageDrivers[activeDriver].MoveTo(Game.GetPlayer())
		Game.DisablePlayerControls(true, true, true, true, true, true, true, true)
		fadeToBlackHoldImod.ApplyCrossFade(1.5)
		Utility.Wait(1.5)
		carriageDrivers[activeDriver].Enable()
		Debug.Notification("A carriage driver has entered the inn.")
		Utility.Wait(1.5)
		ImageSpaceModifier.RemoveCrossFade(1.5)
		Game.EnablePlayerControls()
	endIf
EndFunction

Function Travel(int index)
	Actor player = Game.GetPlayer()
	float deltaWeight = player.GetActorValue("CarryWeight") - player.GetActorValue("InventoryWeight")

	fadeToBlackHoldImod.ApplyCrossFade(1.5)
	Utility.Wait(1.5)
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
	ImageSpaceModifier.RemoveCrossFade(1.5)
EndFunction

Function UpdateLocation(Location oldLoc, Location newLoc)
	showInnkeeperDialogue = IsAccurateInnLoc(newLoc)
	if (waitForDriver && oldLoc == waitLocation)
		RegisterForSingleUpdate(20.0)
	endIf
EndFunction

Function ResetQuest()
	if (carriageDrivers[activeDriver].IsEnabled())
		carriageDrivers[activeDriver].Disable()
	endIf
	waitForDriver = false
	waitLocation = none
	activeDriver = -1
EndFunction