Scriptname WCIQuestScript extends Quest conditional

Actor property playerRef auto
ActorBase[] property carriageDrivers auto
GlobalVariable property carriageCost auto
GlobalVariable property carriageCostSmall auto
GlobalVariable property carriageCostHouse auto
ImageSpaceModifier property fadeToBlackHoldImod auto
Keyword property locTypeInn auto
Location property tamrielLoc auto
Location[] property disabledLocations auto
MiscObject property gold auto
ObjectReference[] property fastTravelMarkers auto

Actor activeDriver
bool showInnkeeperDialogue conditional
bool waitForDriver conditional
float registerTime
float spawnX
float spawnY
float spawnZ
int indexDriver
Location waitLocation

Event OnInit()
	SetDefaultValues()
	SetSpawnPos()
	showInnkeeperDialogue = IsAccurateInnLoc(playerRef.GetCurrentLocation())
	carriageCostHouse.SetValue(carriageCost.GetValue() + carriageCostSmall.GetValue())
	Debug.Trace("WCI: script has been initialized (OnInit)")
EndEvent

Event OnUpdate()
	Debug.Trace("WCI: update (OnUpdate)")
	if (playerRef.GetCurrentLocation() != waitLocation)
		ResetQuest()
	endIf
EndEvent

Function SetDefaultValues()
	activeDriver = none
	waitForDriver = false
	waitLocation = none
	indexDriver = -1
	registerTime = 60.0
EndFunction

Function SetSpawnPos()
	spawnX = playerRef.x
	spawnY = playerRef.y
	spawnZ = playerRef.z
EndFunction

Function UpdateLocation(Location oldLoc, Location newLoc)
	showInnkeeperDialogue = IsAccurateInnLoc(newLoc)
	if (showInnkeeperDialogue)
		SetSpawnPos()
	endIf
	if (waitForDriver && oldLoc == waitLocation)
		Debug.Trace("WCI: player is waiting for driver and has left " \
				+ (waitLocation.GetFormID() as string) + ", registering for update in " \
				+ (registerTime as string) + "s (UpdateLocation)")
		RegisterForSingleUpdate(registerTime)
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
	indexDriver = Utility.RandomInt(0, 3)
	Debug.Trace("WCI: player has requested carriage driver " + (indexDriver as string) \
			+ " in " + (waitLocation.GetFormID() as string) + " (RequestDriver)")
EndFunction

Function CheckSitCondition()
	if (waitForDriver && playerRef.GetCurrentLocation() == waitLocation)
		SpawnCarriageDriver()
	endIf
EndFunction

Function SpawnCarriageDriver()
	if (!activeDriver)
		Game.DisablePlayerControls()
		fadeToBlackHoldImod.ApplyCrossFade(1.5)
		Utility.Wait(1.5)
		activeDriver = playerRef.PlaceActorAtMe(carriageDrivers[indexDriver])
		activeDriver.SetPosition(spawnX, spawnY, spawnZ)
		Debug.Notification("A carriage driver has entered the inn.")
		Utility.Wait(1.5)
		ImageSpaceModifier.RemoveCrossFade(1.5)
		Game.EnablePlayerControls()
		Debug.Trace("WCI: carriage driver " + (indexDriver as string) \
				+ " has been spawned (SpawnCarriageDriver)")
	endIf
EndFunction

Function Travel(int index)
	float dw = playerRef.GetActorValue("CarryWeight") - playerRef.GetActorValue("InventoryWeight")

	Debug.Trace("WCI: preparing to move player (Travel)")
	registerTime = 1.0
	fadeToBlackHoldImod.ApplyCrossFade(1.5)
	Utility.Wait(1.5)
	if (dw < 0)
		playerRef.ModActorValue("CarryWeight", -dw)
	endIf
	Game.FastTravel(fastTravelMarkers[index])
	if (dw < 0)
		playerRef.ModActorValue("CarryWeight", dw)
	endIf
	playerRef.RemoveItem(gold, GetTravelCost(index))
	ImageSpaceModifier.RemoveCrossFade(1.5)
	Debug.Trace("WCI: player has been moved (Travel)")
EndFunction

int Function GetTravelCost(int index)
	if (index < 5)
		return carriageCost.GetValue() as int
	elseif (index < 18)
		return carriageCostSmall.GetValue() as int
	else
		return carriageCostHouse.GetValue() as int
	endIf
EndFunction

Function ResetQuest()
	if (activeDriver)
		activeDriver.Disable()
		activeDriver.Delete()
	endIf
	SetDefaultValues()
	Debug.Trace("WCI: quest has been reset (ResetQuest)")
EndFunction