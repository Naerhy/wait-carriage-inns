Scriptname WCIQuestMCMScript extends SKI_ConfigBase conditional

int markarthOID
int riftenOID
int solitudeOID
int whiterunOID
int windhelmOID
int darkwaterCrossingOID
int dawnstarOID
int dragonBridgeOID
int falkreathOID
int ivarsteadOID
int karthwastenOID
int kynesgroveOID
int morthalOID
int riverwoodOID
int roriksteadOID
int shorsStoneOID
int stonehillsOID
int winterholdOID
int heljarchenHallOID
int lakeviewManorOID
int windstadManorOID

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
	AddCitiesSection()
	AddEmptyOption()
	AddTownsSection()
	SetCursorPosition(1)
	AddSettlementsSection()
	AddEmptyOption()
	AddHearthfiresHomesSection()
EndEvent

Event OnOptionSelect(int option)
	if (option == markarthOID)
		markarth = !markarth
		SetToggleOptionValue(markarthOID, markarth)
	elseif (option == riftenOID)
		riften = !riften
		SetToggleOptionValue(riftenOID, riften)
	elseif (option == solitudeOID)
		solitude = !solitude
		SetToggleOptionValue(solitudeOID, solitude)
	elseif (option == whiterunOID)
		whiterun = !whiterun
		SetToggleOptionValue(whiterunOID, whiterun)
	elseif (option == windhelmOID)
		windhelm = !windhelm
		SetToggleOptionValue(windhelmOID, windhelm)
	elseif (option == darkwaterCrossingOID)
		darkwaterCrossing = !darkwaterCrossing
		SetToggleOptionValue(darkwaterCrossingOID, darkwaterCrossing)
	elseif (option == dawnstarOID)
		dawnstar = !dawnstar
		SetToggleOptionValue(dawnstarOID, dawnstar)
	elseif (option == dragonBridgeOID)
		dragonBridge = !dragonBridge
		SetToggleOptionValue(dragonBridgeOID, dragonBridge)
	elseif (option == falkreathOID)
		falkreath = !falkreath
		SetToggleOptionValue(falkreathOID, falkreath)
	elseif (option == ivarsteadOID)
		ivarstead = !ivarstead
		SetToggleOptionValue(ivarsteadOID, ivarstead)
	elseif (option == karthwastenOID)
		karthwasten = !karthwasten
		SetToggleOptionValue(karthwastenOID, karthwasten)
	elseif (option == kynesgroveOID)
		kynesgrove = !kynesgrove
		SetToggleOptionValue(kynesgroveOID, kynesgrove)
	elseif (option == morthalOID)
		morthal = !morthal
		SetToggleOptionValue(morthalOID, morthal)
	elseif (option == riverwoodOID)
		riverwood = !riverwood
		SetToggleOptionValue(riverwoodOID, riverwood)
	elseif (option == roriksteadOID)
		rorikstead = !rorikstead
		SetToggleOptionValue(roriksteadOID, rorikstead)
	elseif (option == shorsStoneOID)
		shorsStone = !shorsStone
		SetToggleOptionValue(shorsStoneOID, shorsStone)
	elseif (option == stonehillsOID)
		stonehills = !stonehills
		SetToggleOptionValue(stonehillsOID, stonehills)
	elseif (option == winterholdOID)
		winterhold = !winterhold
		SetToggleOptionValue(winterholdOID, winterhold)
	elseif (option == heljarchenHallOID)
		heljarchenHall = !heljarchenHall
		SetToggleOptionValue(heljarchenHallOID, heljarchenHall)
	elseif (option == lakeviewManorOID)
		lakeviewManor = !lakeviewManor
		SetToggleOptionValue(lakeviewManorOID, lakeviewManor)
	elseif (option == windstadManorOID)
		windstadManor = !windstadManor
		SetToggleOptionValue(windstadManorOID, windstadManor)
	else
		; no action is needed
	endIf
EndEvent

Event OnOptionHighlight(int option)
	SetInfoText("Tick to enable, untick to disable.")
EndEvent

Function AddCitiesSection()
	AddHeaderOption("Cities")
	markarthOID = AddToggleOption("Markarth", markarth)
	riftenOID = AddToggleOption("Riften", riften)
	solitudeOID = AddToggleOption("Solitude", solitude)
	whiterunOID = AddToggleOption("Whiterun", whiterun)
	windhelmOID = AddToggleOption("Windhelm", windhelm)
EndFunction

Function AddTownsSection()
	AddHeaderOption("Towns")
	dawnstarOID = AddToggleOption("Dawnstar", dawnstar)
	falkreathOID = AddToggleOption("Falkreath", falkreath)
	morthalOID = AddToggleOption("Morthal", morthal)
	riverwoodOID = AddToggleOption("Riverwood", riverwood)
	winterholdOID = AddToggleOption("Winterhold", winterhold)
EndFunction

Function AddSettlementsSection()
	AddHeaderOption("Settlements")
	darkwaterCrossingOID = AddToggleOption("Darkwater Crossing", darkwaterCrossing)
	dragonBridgeOID = AddToggleOption("Dragon Bridge", dragonBridge)
	ivarsteadOID = AddToggleOption("Ivarstead", ivarstead)
	karthwastenOID = AddToggleOption("Karthwasten", karthwasten)
	kynesgroveOID = AddToggleOption("Kynesgrove", kynesgrove)
	roriksteadOID = AddToggleOption("Rorikstead", rorikstead)
	shorsStoneOID = AddToggleOption("Shor's Stone", shorsStone)
	stonehillsOID = AddToggleOption("Stonehills", stonehills)
EndFunction

Function AddHearthfiresHomesSection()
	AddHeaderOption("Hearthfires homes")
	heljarchenHallOID = AddToggleOption("Heljarchen Hall", heljarchenHall)
	lakeviewManorOID = AddToggleOption("Lakeview Manor", lakeviewManor)
	windstadManorOID = AddToggleOption("Windstad Manor", windstadManor)
EndFunction