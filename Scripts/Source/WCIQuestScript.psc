Scriptname WCIQuestScript extends Quest conditional

Actor property playerRef auto
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
	waitForDriver = false
	waitLocation = none
	activeDriver = -1
	showInnkeeperDialogue = IsAccurateInnLoc(playerRef.GetCurrentLocation())
	carriageCostHouse.SetValue(carriageCost.GetValue() + carriageCostSmall.GetValue())
EndEvent

Event OnUpdate()
	if (playerRef.GetCurrentLocation() != waitLocation)
		ResetQuest()
	endIf
EndEvent

Function UpdateLocation(Location oldLoc, Location newLoc)
	showInnkeeperDialogue = IsAccurateInnLoc(newLoc)
	if (waitForDriver && oldLoc == waitLocation)
		RegisterForSingleUpdate(20.0)
	endIf
EndFunction

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
	waitLocation = playerRef.GetCurrentLocation()
	activeDriver = Utility.RandomInt(0, 2)
EndFunction

Function CheckSitCondition()
	if (waitForDriver && playerRef.GetCurrentLocation() == waitLocation)
		WaitForCarriageDriver()
	endIf
EndFunction

Function WaitForCarriageDriver()
	if (carriageDrivers[activeDriver].IsDisabled())
		carriageDrivers[activeDriver].MoveTo(playerRef)
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
	float deltaWeight = playerRef.GetActorValue("CarryWeight") - playerRef.GetActorValue("InventoryWeight")

	fadeToBlackHoldImod.ApplyCrossFade(1.5)
	Utility.Wait(1.5)
	if (deltaWeight < 0)
		playerRef.ModActorValue("CarryWeight", -deltaWeight)
	endIf
	Game.FastTravel(fastTravelMarkers[index])
	if (deltaWeight < 0)
		playerRef.ModActorValue("CarryWeight", deltaWeight)
	endIf
	if (index < 5)
		playerRef.RemoveItem(gold, carriageCost.GetValue() as int)
	elseif (index < 18)
		playerRef.RemoveItem(gold, carriageCostSmall.GetValue() as int)
	else
		playerRef.RemoveItem(gold, carriageCostHouse.GetValue() as int)
	endIf
	ImageSpaceModifier.RemoveCrossFade(1.5)
EndFunction

Function ResetQuest()
	if (carriageDrivers[activeDriver].IsEnabled())
		carriageDrivers[activeDriver].Disable()
	endIf
	waitForDriver = false
	waitLocation = none
	activeDriver = -1
EndFunction