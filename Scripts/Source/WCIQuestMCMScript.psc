Scriptname WCIQuestMCMScript extends SKI_ConfigBase conditional

Actor property playerRef auto
FormList property excludedLoc auto
WCIQuestScript property mainScript auto

; unable to use array of bool as quest needs to get their value in dialogue conditions
bool markarth conditional
bool riften conditional
bool solitude conditional
bool whiterun conditional
bool windhelm conditional
bool dawnstar conditional
bool falkreath conditional
bool morthal conditional
bool riverwood conditional
bool winterhold conditional
bool darkwaterCrossing conditional
bool dragonBridge conditional
bool ivarstead conditional
bool karthwasten conditional
bool kynesgrove conditional
bool rorikstead conditional
bool shorsStone conditional
bool stonehills conditional
bool heljarchenHall conditional
bool lakeviewManor conditional
bool windstadManor conditional

Event OnConfigInit()
	modName = "Wait Carriage in Inns"
	pages = new string[2]
	pages[0] = "Enabled destinations"
	pages[1] = "Excluded inn locations"
	markarth = true
	riften = true
	solitude = true
	whiterun = true
	windhelm = true
	dawnstar = true
	falkreath = true
	morthal = true
	riverwood = true
	winterhold = true
	darkwaterCrossing = true
	dragonBridge = true
	ivarstead = true
	karthwasten = true
	kynesgrove = true
	rorikstead = true
	shorsStone = true
	stonehills = true
	heljarchenHall = true
	lakeviewManor = true
	windstadManor = true
EndEvent

Event OnPageReset(string page)
	SetCursorFillMode(TOP_TO_BOTTOM)
	if (page == "Enabled destinations")
		RenderEnabledDestinationsPage()
	elseif (page == "Excluded inn locations")
		RenderExcludedInnLocationsPage()
	else
		; no action is needed
	endIf
EndEvent

Function RenderEnabledDestinationsPage()
	AddCitiesSection()
	AddEmptyOption()
	AddTownsSection()
	SetCursorPosition(1)
	AddSettlementsSection()
	AddEmptyOption()
	AddHearthfiresHomesSection()
EndFunction

Function AddCitiesSection()
	AddHeaderOption("Cities")
	AddToggleOptionST("MARKARTH", "Markarth", markarth)
	AddToggleOptionST("RIFTEN", "Riften", riften)
	AddToggleOptionST("SOLITUDE", "Solitude", solitude)
	AddToggleOptionST("WHITERUN", "Whiterun", whiterun)
	AddToggleOptionST("WINDHELM", "Windhelm", windhelm)
EndFunction

Function AddTownsSection()
	AddHeaderOption("Towns")
	AddToggleOptionST("DAWNSTAR", "Dawnstar", dawnstar)
	AddToggleOptionST("FALKREATH", "Falkreath", falkreath)
	AddToggleOptionST("MORTHAL", "Morthal", morthal)
	AddToggleOptionST("RIVERWOOD", "Riverwood", riverwood)
	AddToggleOptionST("WINTERHOLD", "Winterhold", winterhold)
EndFunction

Function AddSettlementsSection()
	AddHeaderOption("Settlements")
	AddToggleOptionST("DARKWATER_CROSSING", "Darkwater Crossing", darkwaterCrossing)
	AddToggleOptionST("DRAGON_BRIDGE", "Dragon Bridge", dragonBridge)
	AddToggleOptionST("IVARSTEAD", "Ivarstead", ivarstead)
	AddToggleOptionST("KARTHWASTEN", "Karthwasten", karthwasten)
	AddToggleOptionST("KYNESGROVE", "Kynesgrove", kynesgrove)
	AddToggleOptionST("RORIKSTEAD", "Rorikstead", rorikstead)
	AddToggleOptionST("SHORS_STONE", "Shor's Stone", shorsStone)
	AddToggleOptionST("STONEHILLS", "Stonehills", stonehills)
EndFunction

Function AddHearthfiresHomesSection()
	AddHeaderOption("Hearthfires homes")
	AddToggleOptionST("HELJARCHEN_HALL", "Heljarchen Hall", heljarchenHall)
	AddToggleOptionST("LAKEVIEW_MANOR", "Lakeview Manor", lakeviewManor)
	AddToggleOptionST("WINDSTAD_MANOR", "Windstad Manor", windstadManor)
EndFunction

Function RenderExcludedInnLocationsPage()
	int flag = OPTION_FLAG_NONE
	Location currentLoc = playerRef.GetCurrentLocation()

	AddHeaderOption("Location information")
	AddTextOptionST("CURRENT_LOCATION", "Current location", currentLoc.GetName())
	if (!mainScript.GetSIDValue() || excludedLoc.HasForm(currentLoc))
		flag = OPTION_FLAG_DISABLED
	endIf
	AddTextOptionST("EXCLUDE_LOCATION", "Click to exclude current inn location", "", flag)
	AddTextOptionST("CLEAR_FORM_LIST", "Clear list", "")
	SetCursorPosition(1)
	AddHeaderOption("List of excluded locations")
	DisplayExcludedLoc()
EndFunction

Function ClearFormList()
	int listSize = excludedLoc.GetSize()

	if (excludedLoc.HasForm(playerRef.GetCurrentLocation()))
		ShowMessage("You cannot clear the list in that location, move to another one.", false)
	else
		while (listSize)
			listSize -= 1
			excludedLoc.RemoveAddedForm(excludedLoc.GetAt(listSize))
		endWhile
	endIf
EndFunction

Function DisplayExcludedLoc()
	int i = 0
	int listSize = excludedLoc.GetSize()
	
	while (i < listSize)
		AddTextOptionST("LIST_ENTRY", i as string, excludedLoc.GetAt(i).GetName())
		i += 1
	endWhile
EndFunction

State MARKARTH
	Event OnSelectST()
		markarth = !markarth
		SetToggleOptionValueST(markarth)
	EndEvent
EndState

State RIFTEN
	Event OnSelectST()
		riften = !riften
		SetToggleOptionValueST(riften)
	EndEvent
EndState

State SOLITUDE
	Event OnSelectST()
		solitude = !solitude
		SetToggleOptionValueST(solitude)
	EndEvent
EndState

State WHITERUN
	Event OnSelectST()
		whiterun = !whiterun
		SetToggleOptionValueST(whiterun)
	EndEvent
EndState

State WINDHELM
	Event OnSelectST()
		windhelm = !windhelm
		SetToggleOptionValueST(windhelm)
	EndEvent
EndState

State DARKWATER_CROSSING
	Event OnSelectST()
		darkwaterCrossing = !darkwaterCrossing
		SetToggleOptionValueST(darkwaterCrossing)
	EndEvent
EndState

State DAWNSTAR
	Event OnSelectST()
		dawnstar = !dawnstar
		SetToggleOptionValueST(dawnstar)
	EndEvent
EndState

State DRAGON_BRIDGE
	Event OnSelectST()
		dragonBridge = !dragonBridge
		SetToggleOptionValueST(dragonBridge)
	EndEvent
EndState

State FALKREATH
	Event OnSelectST()
		falkreath = !falkreath
		SetToggleOptionValueST(falkreath)
	EndEvent
EndState

State IVARSTEAD
	Event OnSelectST()
		ivarstead = !ivarstead
		SetToggleOptionValueST(ivarstead)
	EndEvent
EndState

State KARTHWASTEN
	Event OnSelectST()
		karthwasten = !karthwasten
		SetToggleOptionValueST(karthwasten)
	EndEvent
EndState

State KYNESGROVE
	Event OnSelectST()
		kynesgrove = !kynesgrove
		SetToggleOptionValueST(kynesgrove)
	EndEvent
EndState

State MORTHAL
	Event OnSelectST()
		morthal = !morthal
		SetToggleOptionValueST(morthal)
	EndEvent
EndState

State RIVERWOOD
	Event OnSelectST()
		riverwood = !riverwood
		SetToggleOptionValueST(riverwood)
	EndEvent
EndState

State RORIKSTEAD
	Event OnSelectST()
		rorikstead = !rorikstead
		SetToggleOptionValueST(rorikstead)
	EndEvent
EndState

State SHORS_STONE
	Event OnSelectST()
		shorsStone = !shorsStone
		SetToggleOptionValueST(shorsStone)
	EndEvent
EndState

State STONEHILLS
	Event OnSelectST()
		stonehills = !stonehills
		SetToggleOptionValueST(stonehills)
	EndEvent
EndState

State WINTERHOLD
	Event OnSelectST()
		winterhold = !winterhold
		SetToggleOptionValueST(winterhold)
	EndEvent
EndState

State HELJARCHEN_HALL
	Event OnSelectST()
		heljarchenHall = !heljarchenHall
		SetToggleOptionValueST(heljarchenHall)
	EndEvent
EndState

State LAKEVIEW_MANOR
	Event OnSelectST()
		lakeviewManor = !lakeviewManor
		SetToggleOptionValueST(lakeviewManor)
	EndEvent
EndState

State WINDSTAD_MANOR
	Event OnSelectST()
		windstadManor = !windstadManor
		SetToggleOptionValueST(windstadManor)
	EndEvent
EndState

State EXCLUDE_LOCATION
	Event OnSelectST()
		excludedLoc.AddForm(playerRef.GetCurrentLocation())
		mainScript.ResetQuest()
		mainScript.UpdateLocation(none, playerRef.GetCurrentLocation())
		ForcePageReset()
	EndEvent
EndState

State CLEAR_FORM_LIST
	Event OnSelectST()
		ClearFormList()
		ForcePageReset()
	EndEvent
EndState