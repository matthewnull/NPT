require_game_build(2824) -- GTA Online version 1.66

--Required Keyboard Keys--

		keyboard = 
		{
		numpad0 = 96,
		numpad2 = 98,
		numpad5 = 101,
		numpad8 = 104,
		backspace = 8,
		k = 75,
		enter = 13,
		i = 73
		}

mainMenu = menu.add_submenu("【 CSYON 】 SubMenu 1.66 ")
local function Text(text)
	mainMenu:add_action(text,  function() end)
end

local snowAddress = 262145 + 4752
local isEnabled = false
 
function toggleSnow()
    isEnabled = not isEnabled
    globals.set_boolean(snowAddress, isEnabled)
end
------
local Config = {}
Config.SubmenuStyle = false
Config.SlamType = 1
Config.SlamHeight = 1
Config.SlamTypes = {"Rhino", "Khanjali", "Halftrack"}
Config.VehicleSpawnGlobal = 2639783
Config.VehicleTypes = {}
Config.VehicleTypes["Super"] = {"Krieger", "Prototipo", "T20"}
Config.VehicleTypes["Sports"] = {"Kuruma", "Kuruma2"}
Config.VehicleTypes["Sports Classic"] = {"Toreador", "Artdent"}
Config.VehicleTypes["Millitary"] = {"Rhino", "Khanjali", "Halftrack"}
Config.VehicleTypes["Bikes"] = {"Oppressor", "Oppressor2", "Akuma"}
Config.VehicleTypes["Planes"] = {"Hydra", "Lazer", "Titan", "Cargoplane"}
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--Required Stats--
		
		MPX = PI 
		PI = stats.get_int("MPPLY_LAST_MP_CHAR") 
		if PI == 0 then MPX = "MP0_" else MPX = "MP1_" end
		ASS = script("appsecuroserv")
		GCS = script("gb_contraband_sell")
		GCB = script("gb_contraband_buy")
		AMW = script("am_mp_warehouse")
		GB = script("gb_gunrunning")
		FMC = script("fm_mission_controller")
		FMC20 = script("fm_mission_controller_2020") 
		FormatMoney = (function (n)
		n = tostring(n) return n:reverse():gsub("%d%d%d", "%1,"):reverse():gsub("^,", "") end)
		freemodeglobal = 262145 
            fmC2020 = script("fm_mission_controller_2020")
            fmC = script("fm_mission_controller")
            function TP(x, y, z, yaw, roll, pitch)
            if localplayer:is_in_vehicle()
            then
            localplayer:get_current_vehicle():set_position(x, y, z)
            localplayer:get_current_vehicle():set_rotation(yaw, roll, pitch)
            else localplayer:set_position(x, y, z)
            localplayer:set_rotation(yaw, roll, pitch)
            end
            end 

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local function createVehicle(modelhash, pos)
	globals.set_int(VehicleSpawnGlobal + 46, modelhash)
	globals.set_float(VehicleSpawnGlobal + 42, pos.x)
	globals.set_float(VehicleSpawnGlobal + 43, pos.y)
	globals.set_float(VehicleSpawnGlobal + 44, pos.z)
	globals.set_boolean(VehicleSpawnGlobal + 41, true)
end
------
OnWeaponChanged=38			--	TelePort Forward, Up Arrow key
if csyon then menu.remove_callback(csyon) end local csyon=nil
if enable then local csyon = menu.register_callback('OnWeaponChanged', OnWeaponChanged) end
------
local bT,WR,LR=0,0,0
local function OnWeaponChanged(oldWeapon, newWeapon)
	if newWeapon~=nil then NAME=localplayer:get_current_weapon():get_name_hash()
		if NAME==joaat("weapon_hominglauncher") then newWeapon:set_range(1500) elseif NAME==joaat("weapon_raypistol") then
			newWeapon:set_heli_force(1075) newWeapon:set_ped_force(63) newWeapon:set_vehicle_force(1075) end
		if bT==0 then if NAME==joaat("weapon_stungun_mp") or NAME==joaat("weapon_stungun") then newWeapon:set_time_between_shots(1)
			elseif NAME==joaat("weapon_raypistol") then newWeapon:set_time_between_shots(0.5) end
			else newWeapon:set_time_between_shots(bT) end
		if WR~=0 then newWeapon:set_range(WR) else if NAME==joaat("weapon_raypistol") then newWeapon:set_range(1200)
			elseif NAME==joaat("weapon_stungun_mp") or NAME==joaat("weapon_stungun") then newWeapon:set_range(1000) end end
		if LR==0 then if NAME==joaat("weapon_hominglauncher") then newWeapon:set_lock_on_range(1500) end
			else newWeapon:set_lock_on_range(LR) end end
end
------
local function weaponDamage()
	if localplayer == nil then
		return
	end
	
	current_weapon = localplayer:get_current_weapon()
		if current_weapon ~= nil then
			current_weapon:set_bullet_damage(99900000)
		end
end
------
local function PedDrop()
	local position = localplayer:get_position()
	position.z = position.z + 30
 
	for p in replayinterface.get_peds() do
		if p == nil or p == localplayer then
			goto continue
		end
		
		if p:get_pedtype() < 4 then
			goto continue
		end
		
		if p:is_in_vehicle() then
			goto continue
		end
 
		p:set_position(position)
 
		if p:get_health() > 99 then
			p:set_position(position)
			p:set_freeze_momentum(true)
			p:set_health(0)
			p:set_wallet(1337)
			--p:set_wallet(1337)
			break
		end
 
		::continue::
	end
end
menu.register_hotkey(114, PedDrop) --to drop a ped when pressing F3
------
function cv() c=localplayer v=c and c:get_current_vehicle() return v end
x,o=0,0 menu.register_hotkey(16,function() if x==0 then menu.send_key_down(127) if cv() then 
    
    v:set_drift_tyres_enabled(true) 
    v:set_traction_curve_max(0)
	v:set_traction_curve_min(0)
 
end end x=x+1 end) 
------
menu.register_hotkey(127,function() o=o<x and x or o+1 if o>x then menu.send_key_up(127) if cv() then 
 
    v:set_drift_tyres_enabled(false) 
    v:set_traction_curve_max(2.8)
	v:set_traction_curve_min(2.6)
 
end x,o=0,0 end end)
------
local function DrugWarsUnlockClothes_CSYON()
    for i = 33973, 34112, 1 do
        globals.set_int(262145 + i, 1)
        sleep(2)
    end
end
------
local function StreetDealer_CSYON()
    for i = 34062, 34062, 1 do
        globals.set_int(262145 + i, 1)
        sleep(2)
    end
end
------
local function twentyfive_SkiMask_CSYON()
    for i = 34045, 34045, 1 do
        globals.set_int(262145 + i, 0)
        sleep(2)
    end
end
------
script_name = "fm_mission_controller_2020"
cayo_fingerprint_clone = 22032
cayo_instant_heist_passed_trigger = 42279
cayo_instant_heist_passed_value = 43655
------
local function unlockBLVDGarage_CSYON()
    for i = 32702, 32702, 1 do
        globals.set_int(262145 + i, 1)
        sleep(2)
    end
end
------
local function UnlockExit_CSYON()
    for i = 32688, 32688, 1 do
        globals.set_int(262145 + i, 0)
        sleep(2)
    end
end
------
local function Baseball_Bat_and_Knife_liveries_CSYON()
    for i = 33877, 33877, 1 do
        globals.set_int(262145 + i, 0)
        sleep(2)
    end
end
------Protections
local function KickCrashes(bool)
	if bool then 
		globals.set_bool(1670036, true)
		globals.set_bool(1670051, true)
		globals.set_bool(1669951, true)
		globals.set_bool(1670028, true)
		globals.set_bool(1670238, true)
	else
		globals.set_bool(1670036, false)
		globals.set_bool(1670051, false)
		globals.set_bool(1669951, false)
		globals.set_bool(1670028, false)
		globals.set_bool(1670238, false)
	end
end
 
local function SoundSpam(bool)
	if bool then 
		globals.set_bool(1669879, true)
		globals.set_bool(1670243, true)
		globals.set_bool(1669394, true)
		globals.set_bool(1670529, true)
		globals.set_bool(1670058, true)
		globals.set_bool(1669421, true)
 
	else
		globals.set_bool(1669879, false)
		globals.set_bool(1670243, false) 
		globals.set_bool(1669394, false) 
		globals.set_bool(1670529, false)
		globals.set_bool(1670058, false)
		globals.set_bool(1669421, false)
	end
end
 
local function InfiniteLoad(bool)
	if bool then 		
		globals.set_bool(1669947, true) 
		globals.set_bool(1670076, true)
	else
		globals.set_bool(1669947, false)
		globals.set_bool(1670076, false)
	end
end
 
 
local function Collectibles(bool)
	if bool then 
		globals.set_bool(1670208, true) 
	else
		globals.set_bool(1670208, false)
	end
end
 
local function PassiveMode(bool)
	if bool then 
		globals.set_bool(1669996, true) 
	else
		globals.set_bool(1669996, false)
	end
end
 
local function TransactionError(bool) 
	if bool then 
		globals.set_bool(1669797, true) 
	else
		globals.set_bool(1669797, false)
	end
end
 
local function RemoveMoneyMessage(bool) 
	if bool then 
		globals.set_bool(1669880, true)
		globals.set_bool(1669426, true)
		globals.set_bool(1670057, true)
		globals.set_bool(1669428, true)
	else
		globals.set_bool(1669880, false)
		globals.set_bool(1669426, false)
		globals.set_bool(1670057, false)
		globals.set_bool(1669428, false)
	end
end
 
local function ExtraTeleport(bool) 
	if bool then 
		globals.set_bool(1669741, true) 
		globals.set_bool(1670138, true) 
	else
		globals.set_bool(1669741, false) 
		globals.set_bool(1670138, false) 
	end
end
 
 
local function ClearWanted(bool) 
	if bool then 
		globals.set_bool(1669938, true)
	else
		globals.set_bool(1669938, false)
	end
end
 
local function OffTheRadar(bool) 
	if bool then 
		globals.set_bool(1669940, true)
	else
		globals.set_bool(1669940, false)
	end
end
 
local function SendCutscene(bool) 
	if bool then 
		globals.set_bool(1670198, true)
	else
		globals.set_bool(1670198, false)
	end
end
 
local function Godmode(bool) 
	if bool then 
		globals.set_bool(1669396, true)
	else
		globals.set_bool(1669396, false)
	end
end
 
local function PersonalVehicleDestroy(bool) 
	if bool then 
		globals.set_bool(1669480, true)
		globals.set_bool(1670063, true) 
		globals.set_bool(1669947, true)
		
	else
		globals.set_bool(1669480, false)
		globals.set_bool(1670063, false) 
		globals.set_bool(1669947, false) 
	end
end
local function Bounty(bool) 
	if bool then 
		globals.set_bool(1669471, true)
	else
		globals.set_bool(1669471, false)
	end
end

local function All(bool) 
	SoundSpam(bool)
	InfiniteLoad(bool)
	PassiveMode(bool)
	TransactionError(bool)
	RemoveMoneyMessage(bool)
	ClearWanted(bool)
	OffTheRadar(bool)
	PersonalVehicleDestroy(bool)
	SendCutscene(bool)
	Godmode(bool)
	Collectibles(bool)
	ExtraTeleport(bool)
	KickCrashes(bool)
	Bounty(bool)
end
------
local enabled = false
------
local night = false
local function clubs(state)
    while state do
        stats.set_int("MP0_CLUB_POPULARITY", 1000)
        stats.set_int("MP0_CLUB_PAY_TIME_LEFT", -1)
        sleep(1.5)
        stats.set_int("MP1_CLUB_POPULARITY", 1000)
        stats.set_int("MP1_CLUB_PAY_TIME_LEFT", -1)
        sleep(1.5)
        stats.set_int("MP0_CLUB_POPULARITY", 1000)
        stats.set_int("MP0_CLUB_PAY_TIME_LEFT", -1)
        sleep(1.5)
        stats.set_int("MP1_CLUB_POPULARITY", 1000)
        stats.set_int("MP1_CLUB_PAY_TIME_LEFT", -1)
        sleep(1.5)
        stats.set_int("MP0_CLUB_POPULARITY", 1000)
        stats.set_int("MP0_CLUB_PAY_TIME_LEFT", -1)
        sleep(1.5)
        stats.set_int("MP1_CLUB_POPULARITY", 1000)
        stats.set_int("MP1_CLUB_PAY_TIME_LEFT", -1)
        sleep(1.5)
        stats.set_int("MP0_CLUB_POPULARITY", 1000)
        stats.set_int("MP0_CLUB_PAY_TIME_LEFT", -1)
        sleep(1.5)
        stats.set_int("MP1_CLUB_POPULARITY", 1000)
        stats.set_int("MP1_CLUB_PAY_TIME_LEFT", -1) 
        sleep(1.5)
        stats.set_int("MP0_CLUB_POPULARITY", 1000)
        stats.set_int("MP0_CLUB_PAY_TIME_LEFT", -1)
        sleep(1.5)
        stats.set_int("MP1_CLUB_POPULARITY", 1000)
        stats.set_int("MP1_CLUB_PAY_TIME_LEFT", -1)
        sleep(4)
    end
end
------
function TrickOrTreat(c)
    local index = 34253
    local value = false
    i = math.floor((index - 34251) / 64)
	bit = (index - 34251) % 64
	stathash = MPx().."DLC12022PSTAT_BOOL"..i -- 34251-34763
    stats.set_bool_masked(stathash, value, bit) -- with this stat set to true nothing works... lmao?
 
    globals.set_int(2764906 + 498, 1) -- Timer. Never actually changes. But it is in the code, so we reset it to be safe.
    globals.set_int(262145 + 32759, 0) -- Tunable amount collected.
    globals.set_int(2764906 + 591, c) -- Amount collected. Any value but 10 and 200 will give trick/treat randomly. 10 gives 50k (money method?). 1 should display help text.
    globals.set_int(262145 + 32760, 1) -- Tunable (is halloween enabled?)
    globals.set_int(2765539, 1) -- one of triggers, should be anything but -1
    globals.set_int(2765538, 1)  -- does nothing but maybe important so here for flex
    globals.set_int(2764906 + 564, 8) -- 8 is required for halloween collectibles, can be changed to 17 for buried stash (type of collectible collected maybe?...)
    globals.set_int(2764906 + 512, 1) -- something to do with sound, does maybe nothing but maybe important so here for flex
    globals.set_int(2764906 + 214, 1 << 17) -- Trigger Collect
end
------
function ahc()
--Plushies
globals.set_int(262145+28870,0)--Grindy Poppy Saki Muffy Humpy Smokey
globals.set_int(262145+28871,0)--ShinyWasabiKitty
globals.set_int(262145+28872,0)--PrincessRobotBubblegum
globals.set_int(262145+28873,0)--MasterHentai
end
------
local function Own_Worst_Enemy_CSYON()
    for i = 33716, 33716, 1 do
        globals.set_int(262145 + i, 1)
        sleep(2)
    end
end

local function Stashes_to_Stashes_CSYON()
    for i = 33910, 33910, 1 do
        globals.set_int(262145 + i, 1)
        sleep(2)
    end
end

local function Here_Comes_the_Drop_CSYON()
    for i = 33911, 33911, 1 do
        globals.set_int(262145 + i, 1)
        sleep(2)
    end
end

local function Good_Samarithan_CSYON()
    for i = 33912, 33912, 1 do
        globals.set_int(262145 + i, 1)
        sleep(2)
    end
end

local function Last_Dose_Awards_CSYON()
    for i = 33913, 33913, 1 do
        globals.set_int(262145 + i, 1)
        sleep(2)
    end
end

local function Taxi_Awards_CSYON()
    for i = 33914, 33914, 1 do
        globals.set_int(262145 + i, 1)
        sleep(2)
    end
end
------
local function denim_jackets_CSYON()
    for i = 34047, 34047, 1 do
        globals.set_int(262145 + i, 0)
        sleep(2)
    end
end

local function designer_jeans_CSYON()
    for i = 34051, 34051, 1 do
        globals.set_int(262145 + i, 0)
        sleep(2)
    end
end

local function designer_jeans2_CSYON()
    for i = 34055, 34055, 1 do
        globals.set_int(262145 + i, 0)
        sleep(2)
    end
end
------
local fastRespawnGlobal = 2672505 + 1684 + 756 -- Global_2672505.f_1684.f_756
local isRunning = false
------
local function toggleFastRespawn()
    isRunning = not isRunning
    if isRunning then
        repeat
            local mp = player.get_player_ped()
            if mp ~= nil and mp:get_health() < 100 then
                local fastRespawnGlobalValue = globals.get_int(fastRespawnGlobal)
                globals.set_int(fastRespawnGlobal, fastRespawnGlobalValue | 1 << 1)
            end
            sleep(1)
        until (isRunning == false)
    else
        local fastRespawnGlobalValue = globals.get_int(fastRespawnGlobal)
        globals.set_int(fastRespawnGlobal, fastRespawnGlobalValue & ~(1 << 1))
    end
 
end
------
local cooldownGlobalAddress = 262145 + 31126
local isRemoved = false
 
local function removeCooldown(state)
    if not localplayer then
        return
    end
    if state then
        globals.set_int(cooldownGlobalAddress, 0)
    else
        globals.set_int(cooldownGlobalAddress, 2880)
    end
end
------
local function GetCopPartner()
	local position = localplayer:get_position()
	position.x = position.x + 3

	for p in replayinterface.get_peds() do
		if p == nil or p == localplayer then
			goto continue
		end
		
		if p:get_pedtype() ~= 6 and not (p:get_pedtype() < 4) then -- is Cop
			goto continue
		end
		
		if p:is_in_vehicle() then
			veh = p:get_current_vehicle()
			veh:set_health(0)
		end

		p:set_position(position)
		p:set_config_flag(292, true) -- PED_FLAG_FREEZE
		p:set_config_flag(301, true) -- PED_FLAG_IS_STILL
		-- p:set_model_hash(-150975354)
		--break

		::continue::
	end
end
------

local function giverp()
    if enn then
      menu.end_cutscene()
    end
end
------
--####################################--
local function loop()
--------------------------------------------------------------

    -- call custom functions here to loop 
	 giverp()

---------------------------------------------------------------
end 
 menu.register_hotkey(105, function() loop() end) -- this is automatically called from other script
--####################################--
-- main protection suite
local function protection()
 
	base_address = 1669394
 
	globals.set_bool(base_address + 792, true) -- CRITICAL TUNNELING PROTECTION
	globals.set_bool(base_address + 504, true) -- CRITICAL TUNNELING PROTECTION
	globals.set_bool(base_address + 642, true) -- kick crashes
	globals.set_bool(base_address + 657, true) -- kick crashes
	globals.set_bool(base_address + 557, true) -- kick crashes
	globals.set_bool(base_address + 634, true) -- kick crashes
	globals.set_bool(base_address + 844, true) -- kick crashes
	globals.set_bool(base_address + 485, true) -- sound spam
	globals.set_bool(base_address + 849, true) -- sound spam
	globals.set_bool(base_address + 0, true) -- sound spam
	globals.set_bool(base_address + 1135, true) -- sound spam
	globals.set_bool(base_address + 664, true) -- sound spam
	globals.set_bool(base_address + 27, true) -- sound spam
	globals.set_bool(base_address + 553, true) -- infinite load 
	globals.set_bool(base_address + 682, true) -- infinite load 
	globals.set_bool(base_address + 814, true) -- prevent +Collectibles
	globals.set_bool(base_address + 602, true) -- Passive Mode
	globals.set_bool(base_address + 403, true) -- Transaction Error
	globals.set_bool(base_address + 486, true) -- block SMS spam
	globals.set_bool(base_address + 32, true) -- block SMS spam
	globals.set_bool(base_address + 663, true) -- block SMS spam
	globals.set_bool(base_address + 34, true) -- block SMS spam
	globals.set_bool(base_address + 804, true) -- send to cutscene
	globals.set_bool(base_address + 2, true) -- deactivate godmode
	globals.set_bool(base_address + 86, true) -- personal vehicle destroy
	globals.set_bool(base_address + 669, true) -- personal vehicle destroy 
	globals.set_bool(base_address + 553, true) -- personal vehicle destroy
 
end
------
------
------
------
------
------
------
------
------
------
------
------
------
------
------
------
------
------
------
------
------
------
------
------
------
------
------
------ 【 S 】 Car boost Hotkey INSERT

Text("**************************************************************************")
Text("            ** CSYON SubMenu 1.66 **                  ")
Text("                               **✅ v6.5 **                   ")
Text("            ** ⚠️Game Build Version 2824⚠️ **                  ")
Text("**************************************************************************")

Online= mainMenu:add_submenu("🚨  GTAOnline")

CSYON2 = Online:add_submenu("✨ Unlock Misc")

--CSYON3 = Online:add_submenu("👨 Development Test")

CSYON4 = Online:add_submenu("🔫 Weapon Features")

CSYON5 = Online:add_submenu("🚗Vehicles Features")

CSYON6 = Online:add_submenu("🛡️ Protections")

CSYON7 = Online:add_submenu("🕺 Players Features")

CSYON8 = Online:add_submenu("🎮Unlock Alls")

CSYON9 = Online:add_submenu("💵 Money Options")

CSYON10 = Online:add_submenu("🗞 Level Options")

CSYON11 = Online:add_submenu("🧨 Trolling Options")

CSYONS2 = CSYON2:add_submenu("✨ Misc things activater unlocker ")
--CSYONS3 = CSYON3:add_submenu("👨 Development options ")
CSYONS4 = CSYON4:add_submenu("🔫 Weapon options? ")
CSYONS5 = CSYON5:add_submenu("🚗 Vehicles Modifications? ")
CSYONS6 = CSYON6:add_submenu("🛡️ want Protections? ")
CSYONS7 = CSYON7:add_submenu("🕺 Players Mods? ")
CSYONS8 = CSYON8:add_submenu("🎮Unlock All? ")
CSYONS9 = CSYON9:add_submenu("💵 Money? ")
CSYONS10 = CSYON10:add_submenu("🗞 Level? ")
CSYONS11 = CSYON11:add_submenu("🧨 do you want Trolling? ")

local enn = false CSYONS2:add_toggle("Automatically Skip Cutscene", function() return enn end, function(value) enn = value end)

CSYONS11:add_action("Get Partner", GetCopPartner)

CSYONS8:add_action("Unlock Double Action Revolver",function()
if (stats.get_masked_int(mpx.."GANGOPSPSTAT_INT102", 24, 8)<3) then
	stats.set_masked_int(mpx.."GANGOPSPSTAT_INT102", 3, 24, 8)
end
if (stats.get_masked_int(mpx.."GANGOPSPSTAT_INT102", 24, 8) > 3) then
	stats.set_masked_int(mpx.."GANGOPSPSTAT_INT102", 0, 24, 8)
end
end)
	
CSYONS8:add_action("Unlock Stone Hatchet",function()
if (stats.get_masked_int("MP_NGDLCPSTAT_INT0", 16, 8)<5)then
	stats.set_masked_int("MP_NGDLCPSTAT_INT0", 5, 16, 8)
end
if (stats.get_masked_int("MP_NGDLCPSTAT_INT0", 16, 8)>5)then
	stats.set_masked_int("MP_NGDLCPSTAT_INT0", 0, 16, 8)
end	
end)

CSYONS8:add_action("Unlock Guns liveris", function()
	stats.set_int(mpx .. "CHAR_WEAP_UNLOCKED", -1)
	stats.set_int(mpx .. "CHAR_WEAP_UNLOCKED2", -1)
	stats.set_int(mpx .. "CHAR_WEAP_UNLOCKED3", -1)
	stats.set_int(mpx .. "CHAR_WEAP_UNLOCKED4", -1)
	stats.set_int(mpx .. "CHAR_WEAP_ADDON_1_UNLCK", -1)
	stats.set_int(mpx .. "CHAR_WEAP_ADDON_2_UNLCK", -1)
	stats.set_int(mpx .. "CHAR_WEAP_ADDON_3_UNLCK", -1)
	stats.set_int(mpx .. "CHAR_WEAP_ADDON_4_UNLCK", -1)
	stats.set_int(mpx .. "CHAR_WEAP_FREE", -1)
	stats.set_int(mpx .. "CHAR_WEAP_FREE2", -1)
	stats.set_int(mpx .. "CHAR_FM_WEAP_FREE", -1)
	stats.set_int(mpx .. "CHAR_FM_WEAP_FREE2", -1)
	stats.set_int(mpx .. "CHAR_FM_WEAP_FREE3", -1)
	stats.set_int(mpx .. "CHAR_FM_WEAP_FREE4", -1)
	stats.set_int(mpx .. "CHAR_WEAP_PURCHASED", -1)
	stats.set_int(mpx .. "CHAR_WEAP_PURCHASED2", -1)
	stats.set_int(mpx .. "WEAPON_PICKUP_BITSET", -1)
	stats.set_int(mpx .. "WEAPON_PICKUP_BITSET2", -1)
	stats.set_int(mpx .. "CHAR_FM_WEAP_UNLOCKED", -1)
	stats.set_int(mpx .. "NO_WEAPONS_UNLOCK", -1)
	stats.set_int(mpx .. "NO_WEAPON_MODS_UNLOCK", -1)
	stats.set_int(mpx .. "NO_WEAPON_CLR_MOD_UNLOCK", -1) 
	stats.set_int(mpx .. "CHAR_FM_WEAP_UNLOCKED2", -1)
	stats.set_int(mpx .. "CHAR_FM_WEAP_UNLOCKED3", -1)
	stats.set_int(mpx .. "CHAR_FM_WEAP_UNLOCKED4", -1)
	stats.set_int(mpx .. "CHAR_KIT_1_FM_UNLCK", -1)
	stats.set_int(mpx .. "CHAR_KIT_2_FM_UNLCK", -1)
	stats.set_int(mpx .. "CHAR_KIT_3_FM_UNLCK", -1)
	stats.set_int(mpx .. "CHAR_KIT_4_FM_UNLCK", -1)
	stats.set_int(mpx .. "CHAR_KIT_5_FM_UNLCK", -1)
	stats.set_int(mpx .. "CHAR_KIT_6_FM_UNLCK", -1)
	stats.set_int(mpx .. "CHAR_KIT_7_FM_UNLCK", -1)
	stats.set_int(mpx .. "CHAR_KIT_8_FM_UNLCK", -1)
	stats.set_int(mpx .. "CHAR_KIT_9_FM_UNLCK", -1)
	stats.set_int(mpx .. "CHAR_KIT_10_FM_UNLCK", -1)
	stats.set_int(mpx .. "CHAR_KIT_11_FM_UNLCK", -1)
	stats.set_int(mpx .. "CHAR_KIT_12_FM_UNLCK", -1)
	stats.set_int(mpx .. "CHAR_KIT_FM_PURCHASE", -1)
	stats.set_int(mpx .. "CHAR_WEAP_FM_PURCHASE", -1)
	stats.set_int(mpx .. "CHAR_WEAP_FM_PURCHASE2", -1)
	stats.set_int(mpx .. "CHAR_WEAP_FM_PURCHASE3", -1)
	stats.set_int(mpx .. "CHAR_WEAP_FM_PURCHASE4", -1)
	stats.set_int(mpx .. "FIREWORK_TYPE_1_WHITE", 1000)
	stats.set_int(mpx .. "FIREWORK_TYPE_1_RED", 1000)
	stats.set_int(mpx .. "FIREWORK_TYPE_1_BLUE", 1000)
	stats.set_int(mpx .. "FIREWORK_TYPE_2_WHITE", 1000)
	stats.set_int(mpx .. "FIREWORK_TYPE_2_RED", 1000)
	stats.set_int(mpx .. "FIREWORK_TYPE_2_BLUE", 1000)
	stats.set_int(mpx .. "FIREWORK_TYPE_3_WHITE", 1000)
	stats.set_int(mpx .. "FIREWORK_TYPE_3_RED", 1000)
	stats.set_int(mpx .. "FIREWORK_TYPE_3_BLUE", 1000)
	stats.set_int(mpx .. "FIREWORK_TYPE_4_WHITE", 1000)
	stats.set_int(mpx .. "FIREWORK_TYPE_4_RED", 1000)
	stats.set_int(mpx .. "FIREWORK_TYPE_4_BLUE", 1000)
	stats.set_int(mpx .. "WEAP_FM_ADDON_PURCH", -1)
   for i = 2, 19 do stats.set_int(mpx .. "WEAP_FM_ADDON_PURCH"..i, -1) end
   for j = 1, 19 do stats.set_int(mpx .. "CHAR_FM_WEAP_ADDON_"..j.."_UNLCK", -1) end
   for m = 1, 41 do stats.set_int(mpx .. "CHAR_KIT_"..m.."_FM_UNLCK", -1) end
   for l = 2, 41 do stats.set_int(mpx .. "CHAR_KIT_FM_PURCHASE"..l, -1) end
end)

CSYONS8:add_action("Get all Weapons n Upgrades (Temporary)", function()
 stats.set_int(mpx .. "CHAR_WEAP_ADDON_1_UNLCK", -1)
 stats.set_int(mpx .. "CHAR_WEAP_ADDON_2_UNLCK", -1)
 stats.set_int(mpx .. "CHAR_WEAP_ADDON_3_UNLCK", -1)
 stats.set_int(mpx .. "CHAR_WEAP_ADDON_4_UNLCK", -1)
 stats.set_int(mpx .. "CHAR_WEAP_FREE", -1)
 stats.set_int(mpx .. "CHAR_WEAP_FREE2", -1)
 stats.set_int(mpx .. "CHAR_FM_WEAP_FREE", -1)
 stats.set_int(mpx .. "CHAR_FM_WEAP_FREE2", -1)
 stats.set_int(mpx .. "CHAR_FM_WEAP_FREE3", -1)
 stats.set_int(mpx .. "CHAR_FM_WEAP_FREE4", -1)
 stats.set_int(mpx .. "CHAR_WEAP_PURCHASED", -1)
 stats.set_int(mpx .. "CHAR_WEAP_PURCHASED2", -1)
 stats.set_int(mpx .. "WEAPON_PICKUP_BITSET", -1)
 stats.set_int(mpx .. "WEAPON_PICKUP_BITSET2", -1)
 stats.set_int(mpx .. "CHAR_FM_WEAP_UNLOCKED", -1)
 stats.set_int(mpx .. "NO_WEAPONS_UNLOCK", -1)
 stats.set_int(mpx .. "NO_WEAPON_MODS_UNLOCK", -1)
 stats.set_int(mpx .. "NO_WEAPON_CLR_MOD_UNLOCK", -1)
 stats.set_int(mpx .. "CHAR_KIT_FM_PURCHASE", -1)
 stats.set_int(mpx .. "CHAR_WEAP_FM_PURCHASE", -1)
 stats.set_int(mpx .. "CHAR_WEAP_FM_PURCHASE2", -1)
 stats.set_int(mpx .. "CHAR_WEAP_FM_PURCHASE3", -1)
 stats.set_int(mpx .. "CHAR_WEAP_FM_PURCHASE4", -1)
 stats.set_int(mpx .. "WEAP_FM_ADDON_PURCH", -1)
 for i = 2, 19 do
 stats.set_int(mpx .. "WEAP_FM_ADDON_PURCH"..i, -1) end
 for l = 2, 41 do
 stats.set_int(mpx .. "CHAR_KIT_FM_PURCHASE"..l, -1) end
 globals.set_int(1575015, 1)
 globals.set_int(1575015, 1)
 globals.set_int(1574589, 1) sleep(0.2)
 globals.set_int(1574589, 0) 
end)

CSYONS8:add_action("Unlock All LSC", function()
			stats.set_int(MPX .. "CHAR_FM_CARMOD_1_UNLCK", -1)
			stats.set_int(MPX .. "CHAR_FM_CARMOD_2_UNLCK", -1)
			stats.set_int(MPX .. "CHAR_FM_CARMOD_3_UNLCK", -1)
			stats.set_int(MPX .. "CHAR_FM_CARMOD_4_UNLCK", -1)
			stats.set_int(MPX .. "CHAR_FM_CARMOD_5_UNLCK", -1)
			stats.set_int(MPX .. "CHAR_FM_CARMOD_6_UNLCK", -1)
			stats.set_int(MPX .. "CHAR_FM_CARMOD_7_UNLCK", -1)
			stats.set_int(MPX .. "AWD_WIN_CAPTURES", 50)
			stats.set_int(MPX .. "AWD_DROPOFF_CAP_PACKAGES", 100)
			stats.set_int(MPX .. "AWD_KILL_CARRIER_CAPTURE", 100)
			stats.set_int(MPX .. "AWD_FINISH_HEISTS", 50)
			stats.set_int(MPX .. "AWD_FINISH_HEIST_SETUP_JOB", 50)
			stats.set_int(MPX .. "AWD_NIGHTVISION_KILLS", 100)
			stats.set_int(MPX .. "AWD_WIN_LAST_TEAM_STANDINGS", 50)
			stats.set_int(MPX .. "AWD_ONLY_PLAYER_ALIVE_LTS", 50)
			stats.set_int(MPX .. "AWD_FMRALLYWONDRIVE", 25)
			stats.set_int(MPX .. "AWD_FMRALLYWONNAV", 25)
			stats.set_int(MPX .. "AWD_FMWINSEARACE", 25)
			stats.set_int(MPX .. "AWD_RACES_WON", 50)
			stats.set_int(MPX .. "MOST_FLIPS_IN_ONE_JUMP", 5)
			stats.set_int(MPX .. "MOST_SPINS_IN_ONE_JUMP", 5)
			stats.set_int(MPX .. "NUMBER_SLIPSTREAMS_IN_RACE", 100)
			stats.set_int(MPX .. "NUMBER_TURBO_STARTS_IN_RACE", 50)
			stats.set_int(MPX .. "RACES_WON", 50)
			stats.set_int(MPX .. "USJS_COMPLETED", 50)
			stats.set_int(MPX .. "USJS_FOUND", 50)
			stats.set_int(MPX .. "USJS_TOTAL_COMPLETED", 50)
			stats.set_int(MPX .. "AWD_FM_GTA_RACES_WON", 50)
			stats.set_int(MPX .. "AWD_FM_RACE_LAST_FIRST", 25)
			stats.set_int(MPX .. "AWD_FM_RACES_FASTEST_LAP", 50)
			stats.set_int(MPX .. "AWD_FMBASEJMP", 25)
			stats.set_int(MPX .. "AWD_FMWINAIRRACE", 25)
			stats.set_int(MPX .. "TOTAL_RACES_WON", 50) end)

CSYONS2:add_action("Unlock All Bunker(Tempo)", function()
		for j = 0, 63 do
			stats.set_bool_masked(MPX .. "DLCGUNPSTAT_BOOL0", true, j, MPX)
			stats.set_bool_masked(MPX .. "DLCGUNPSTAT_BOOL1", true, j, MPX)
			stats.set_bool_masked(MPX .. "DLCGUNPSTAT_BOOL2", true, j, MPX)
			stats.set_bool_masked(MPX .. "GUNTATPSTAT_BOOL0", true, j, MPX)
			stats.set_bool_masked(MPX .. "GUNTATPSTAT_BOOL1", true, j, MPX)
			stats.set_bool_masked(MPX .. "GUNTATPSTAT_BOOL2", true, j, MPX)
			stats.set_bool_masked(MPX .. "GUNTATPSTAT_BOOL3", true, j, MPX)
			stats.set_bool_masked(MPX .. "GUNTATPSTAT_BOOL4", true, j, MPX)
			stats.set_bool_masked(MPX .. "GUNTATPSTAT_BOOL5", true, j, MPX) end end)

	 CSYONS8:add_array_item("Bunker Research", {"Speed Up", "Reset Speed"}, function()
                               return xox_26 end, function(value)
                               if value == 1
                               then
                               globals.set_int(BRE1,  1)
                               globals.set_int(BRE2,  1)
                               globals.set_int(BRE3,  1)
                               globals.set_int(BRE4,  1)
                               globals.set_int(BRE5,  0)
                               globals.set_int(BRE6,  0)
                               menu.trigger_bunker_research()
                               elseif value == 2 then globals.set_int(BRE1, 60)
                               globals.set_int(BRE3,  45000)
                               globals.set_int(BRE2,  300000)
                               globals.set_int(BRE4,  45000)
                               globals.set_int(BRE5,  2)
                               globals.set_int(BRE6,  1)
                               end xox_26 = value
                               end)

CSYONS2:add_action("Unlock Denim Jackets Drug wars dlc",
    function()
        denim_jackets_CSYON()
    end
)

CSYONS2:add_action("Unlock Designer Jeans Drug wars dlc",
    function()
        designer_jeans_CSYON()
    end
)

CSYONS2:add_action("Unlock Designer Jean Drug wars dlc",
    function()
        designer_jeans2_CSYON()
    end
)

CSYONS2:add_action("Unlock 25 Ski mask Drug wars dlc",
    function()
        twentyfive_SkiMask_CSYON()
    end
)

CSYONS2:add_action("Unlock Own Worst Enemy 60",
    function()
        Own_Worst_Enemy_CSYON()
    end
)

CSYONS2:add_action("Unlock Stashes to Stashes 50",
    function()
        Stashes_to_Stashes_CSYON()
    end
)

CSYONS2:add_action("Unlock Here Comes the Drop 50",
    function()
        Here_Comes_the_Drop_CSYON()
    end
)

CSYONS2:add_action("Unlock Good Samarithan 5",
    function()
        Good_Samarithan_CSYON()
    end
)

CSYONS2:add_action("Unlock Last Dose Awards",
    function()
        Last_Dose_Awards_CSYON()
    end
)

CSYONS2:add_action("Unlock Taxi Awards 50 / 10",
    function()
        Taxi_Awards_CSYON()
    end
)

-- executes main protection set_bools on load-in of this script
protection()
 
-- executes main protection set_bools on player change
menu.register_callback('OnPlayerChanged', function() protection() end)
 
-- the following toggle adds additional protections though if active they can break some Missions + Heists
CSYONS6:add_toggle('ADDL PROTECTIONS - can break Missions + Heists', function()
	return protections_bool
	end, function()
	protections_bool = not protections_bool
	globals.set_bool(base_address + 544, protections_bool) -- clear wanted
	globals.set_bool(base_address + 546, protections_bool) -- off the radar
	globals.set_bool(base_address + 347, protections_bool) -- teleport
	globals.set_bool(base_address + 744, protections_bool) -- teleport 
 
end)

CSYONS8:add_action("Unlock Casino Heist|", function()
	stats.set_int(MPx().."CAS_HEIST_FLOW", -1610744257)
end)

CSYONS2:add_toggle("Remove AutoShop Cooldown", function()
        return isRemoved
    end,
    function()
        isRemoved = not isRemoved
        removeCooldown(isRemoved)
    end
)

CSYONS2:add_toggle("Fast Respawn", function()
    return isRunning
end, toggleFastRespawn)

CSYONS9:add_action("Nightclub 1Bil Rip SharkCards", function()
 stats.set_int(mpx .. "PROP_NIGHTCLUB_VALUE", 1999000000)
 end)

CysonsNotes = CSYONS9:add_submenu("how the use Nightclub1B")

CysonsNotes:add_action("First Enable Nightclub 1Bil Rip SharkCards", function() end)

CysonsNotes:add_action("Then Go To Maze Bank Forclosure", function() end)

CysonsNotes:add_action("Website Then", function() end)

CysonsNotes:add_action("Trade Your Old", function() end)

CysonsNotes:add_action("Night Club With New One", function() end)

CysonsNotes:add_action("And Finally Click On Buy", function() end)

CysonsNotes:add_action("After You Done The Previous Steps", function() end)

CysonsNotes:add_action("Correctly", function() end)

CysonsNotes:add_action("You Will Get 1 Bil Instantly", function() end)

CysonsNotes:add_action("for help join my", function() end)

CysonsNotes:add_action("Discord Server", function() end)

CysonsNotes:add_action("https://discord.gg/JaCvtj6yQK", function() end)

local enabled = true
CSYONS10:add_action("--- reset level ---", function() end)
local first = true
local function resetmenu()
               CSYONS10:clear()
               CSYONS10:add_action("--- reset level ---", function() end)
               enabled = not enabled

               CSYONS10:add_toggle("Reset level to 5", function() return enabled end,function()local mpIndex = globals.get_int(1574915) 
                    if mpIndex ~= nil then
                        if mpIndex > 1 or mpIndex < 0 then
                            return
                        end
                        enabled = not enabled
                        local newRP = globals.get_int(294355 + 5) + 100
                        if mpIndex == 0 then
						    stats.set_int("MP1_CHAR_SET_RP_GIFT_ADMIN", newRP)
                            stats.set_int("MP0_CHAR_SET_RP_GIFT_ADMIN", newRP)
                        else
						    stats.set_int("MP1_CHAR_SET_RP_GIFT_ADMIN", newRP)
                            stats.set_int("MP0_CHAR_SET_RP_GIFT_ADMIN", newRP)
                        end
                        resetmenu()
                     end 
            end) 

            CSYONS10:add_toggle("Reset level to 32", function() return enabled end,function()local mpIndex = globals.get_int(1574915) 
                    if mpIndex ~= nil then
                        if mpIndex > 1 or mpIndex < 0 then
                            return
                        end
                        enabled = not enabled
                        local newRP = 200000
                        if mpIndex == 0 then
                            stats.set_int("MP1_CHAR_SET_RP_GIFT_ADMIN", newRP)
							stats.set_int("MP0_CHAR_SET_RP_GIFT_ADMIN", newRP)
                        else
                            stats.set_int("MP1_CHAR_SET_RP_GIFT_ADMIN", newRP)
							stats.set_int("MP0_CHAR_SET_RP_GIFT_ADMIN", newRP)
                        end
                        resetmenu()
                     end 
            end)
            
            CSYONS10:add_toggle("Reset level to 75", function() return enabled end,function()local mpIndex = globals.get_int(1574915) 
                    if mpIndex ~= nil then
                        if mpIndex > 1 or mpIndex < 0 then
                            return
                        end
                        enabled = not enabled
                        local newRP = 938715
                        if mpIndex == 0 then
                            stats.set_int("MP1_CHAR_SET_RP_GIFT_ADMIN", newRP)
							stats.set_int("MP0_CHAR_SET_RP_GIFT_ADMIN", newRP)
                        else
                            stats.set_int("MP1_CHAR_SET_RP_GIFT_ADMIN", newRP)
							stats.set_int("MP0_CHAR_SET_RP_GIFT_ADMIN", newRP)
                        end
                        resetmenu()
                     end 
            end) 
            
            CSYONS10:add_int_range("Set custom rp level ", 10000, 538715, 80000000, function() return 1 end, function(value)
            local mpIndex = globals.get_int(1574907) 
                    if mpIndex ~= nil then
                        if mpIndex > 1 or mpIndex < 0 then
                            return
                        end
                        enabled = not enabled
                        local newRP = value
                        if mpIndex == 0 then
                            stats.set_int("MP0_CHAR_SET_RP_GIFT_ADMIN", newRP)
							stats.set_int("MP1_CHAR_SET_RP_GIFT_ADMIN", newRP)
                        else
							stats.set_int("MP0_CHAR_SET_RP_GIFT_ADMIN", newRP)
                            stats.set_int("MP1_CHAR_SET_RP_GIFT_ADMIN", newRP)
                        end
                        resetmenu()
                     end 
            end)
            
            
            if first then
                first = false
            else
                CSYONS10:add_action("--- now join a new session! ---", function() end)
            end
end
resetmenu()

CSYONS10:add_action("Unlock all with 120 level", function()
	mpIndex = globals.get_int(1574907)
	if mpIndex == 0 then
		stats.set_int("MP0_CHAR_SET_RP_GIFT_ADMIN", 2165850 )
	else
		stats.set_int("MP1_CHAR_SET_RP_GIFT_ADMIN", 2165850 )
	end
end)

CSYONS10:add_action("444 level", function()
	mpIndex = globals.get_int(1574907)
	if mpIndex == 0 then
		stats.set_int("MP0_CHAR_SET_RP_GIFT_ADMIN", 14372550 )
		stats.set_int("MP1_CHAR_SET_RP_GIFT_ADMIN", 14372550 )
	else
		stats.set_int("MP1_CHAR_SET_RP_GIFT_ADMIN", 14372550 )
		stats.set_int("MP0_CHAR_SET_RP_GIFT_ADMIN", 14372550 )
	end
end)

CSYONS10:add_action("666 level", function()
	mpIndex = globals.get_int(1574907)
	if mpIndex == 0 then
		stats.set_int("MP0_CHAR_SET_RP_GIFT_ADMIN", 25766700 )
		stats.set_int("MP1_CHAR_SET_RP_GIFT_ADMIN", 25766700 )
	else
		stats.set_int("MP1_CHAR_SET_RP_GIFT_ADMIN", 25766700 )
		stats.set_int("MP0_CHAR_SET_RP_GIFT_ADMIN", 25766700 )
	end
end)

CSYONS8:add_action("Bunch of Clothing at Shops", function()
	globals.set_int(296190, 1)
	globals.set_int(296191, 1)
	globals.set_int(296192, 1)
	globals.set_int(296193, 1)
	globals.set_int(296194, 1)
	globals.set_int(296195, 1)
	globals.set_int(296196, 1)
	globals.set_int(296197, 1)
	globals.set_int(296198, 1)
	globals.set_int(296199, 1)
	globals.set_int(296200, 1)
	globals.set_int(296201, 1)
	globals.set_int(296203, 1)
	globals.set_int(296204, 1)
	globals.set_int(296206, 1)
	globals.set_int(296207, 1)
	globals.set_int(296211, 1)
	globals.set_int(296215, 1)
	globals.set_int(296223, 1)
	globals.set_int(296254, 1)
end)

CSYONS8:add_action("Biker DLC unlocks", function()
    for i = 0, 2 do
        for j = 0, 63 do
            stats.set_bool_masked(MPx() .. "DLCBIKEPSTAT_BOOL" .. i, true, j)
            sleep(0.1)
        end
    end
end)

CSYONS8:add_action("Trigger TrickOrTreat", function()
    TrickOrTreat(5) -- Normal collect
end)
 
CSYONS8:add_action("Trigger TrickOrTreat 2", function()
    TrickOrTreat(11) -- No full screen text
end)
 
CSYONS8:add_action("Trigger Money", function()
    TrickOrTreat(10) -- 50k
end)
 
CSYONS8:add_action("Trigger Treat", function()
    TrickOrTreat(200) -- Only treat
end)
 
CSYONS8:add_action("Trigger Help", function()
    TrickOrTreat(0) -- Help text
end)
 
CSYONS8:add_action("Trigger Up-n-Atomizer Trick", function()
    globals.set_int(2764906 + 579, 0) -- Trick type (0-3)
    globals.set_int(2764906 + 581, 1000000) -- Time. Does nothing? afaik
    globals.set_int(2764906 + 581 + 1, 1) -- Trigger. Should be 1
end)
 
CSYONS8:add_action("Trigger Explosion Trick", function()
    globals.set_int(2764906 + 579, 1) -- Trick type (0-3)
    globals.set_int(2764906 + 581, 1000000) -- Time. Does nothing? afaik
    globals.set_int(2764906 + 581 + 1, 1) -- Trigger. Should be 1
end)
 
CSYONS8:add_action("Trigger Drugs Trick", function()
    globals.set_int(2764906 + 579, 2) -- Trick type (0-3)
    globals.set_int(2764906 + 581, 1000000) -- Time. Does nothing? afaik
    globals.set_int(2764906 + 581 + 1, 1) -- Trigger. Should be 1
end)
 
CSYONS8:add_action("Trigger Shocker Trick", function()
    globals.set_int(2764906 + 579, 3) -- Trick type (0-3)
    globals.set_int(2764906 + 581, 1000000) -- Time. Does nothing? afaik
    globals.set_int(2764906 + 581 + 1, 1) -- Trigger. Should be 1
end)

CSYONS8:add_action("Unlock Rare Tattoos Boy", function()
	stats.set_bool_masked(mpx() .. "GUNTATPSTAT_BOOL2", true, 47)  --  Unlock for Alien Tattoo
	stats.set_bool_masked(mpx() .. "GUNTATPSTAT_BOOL5", true, 5)  --  Unlock for Lucky 7s
	stats.set_bool_masked(mpx() .. "GUNTATPSTAT_BOOL5", true, 12)  --  Unlock for The Royals
end)

CSYONS8:add_action("Unlock Rare Tattoos Girl", function()
	stats.set_bool_masked(mpx() .. "GUNTATPSTAT_BOOL2", true, 58)  --  Unlock for Alien Tattoo
	stats.set_bool_masked(mpx() .. "GUNTATPSTAT_BOOL5", true, 16)  --  Unlock for Lucky 7s
	stats.set_bool_masked(mpx() .. "GUNTATPSTAT_BOOL5", true, 23)  --  Unlock for The Royals
end)

CSYONS8:add_action("Unlock Rare Aged T-Shirts Girl", function()
	stats.set_bool_masked(mpx() .. "HEIST3TATTOOSTAT_BOOL1", true, 9)  --  Unlock for BCTR Aged Tee*
	stats.set_bool_masked(mpx() .. "HEIST3TATTOOSTAT_BOOL1", true, 11)  --  Unlock for Cultstopeprs Aged Tee*
	stats.set_bool_masked(mpx() .. "HEIST3TATTOOSTAT_BOOL1", true, 13)  --  Unlock for Daily Globe Aged Tee*
	stats.set_bool_masked(mpx() .. "HEIST3TATTOOSTAT_BOOL1", true, 15)  --  Unlock for Eyefind Aged Tee*
	stats.set_bool_masked(mpx() .. "HEIST3TATTOOSTAT_BOOL1", true, 17)  --  Unlock for Facade Aged Tee*
	stats.set_bool_masked(mpx() .. "HEIST3TATTOOSTAT_BOOL1", true, 19)  --  Unlock for Fruit Aged Tee*
	stats.set_bool_masked(mpx() .. "HEIST3TATTOOSTAT_BOOL1", true, 21)  --  Unlock for LSHH Aged Tee*
	stats.set_bool_masked(mpx() .. "HEIST3TATTOOSTAT_BOOL1", true, 23)  --  Unlock for MyRoom Aged Tee*
	stats.set_bool_masked(mpx() .. "HEIST3TATTOOSTAT_BOOL1", true, 25)  --  Unlock for Rebel Aged Tee*
	stats.set_bool_masked(mpx() .. "HEIST3TATTOOSTAT_BOOL1", true, 27)  --  Unlock for Six Figure Aged Tee*
	stats.set_bool_masked(mpx() .. "HEIST3TATTOOSTAT_BOOL1", true, 29)  --  Unlock for Trash Or Treasure Aged Tee*
	stats.set_bool_masked(mpx() .. "HEIST3TATTOOSTAT_BOOL1", true, 31)  --  Unlock for TW@ Logo Aged Tee*
	stats.set_bool_masked(mpx() .. "HEIST3TATTOOSTAT_BOOL1", true, 33)  --  Unlock for Vapers Den Aged Tee*
	stats.set_bool_masked(mpx() .. "HEIST3TATTOOSTAT_BOOL1", true, 35)  --  Unlock for WingIt Aged Tee*
	stats.set_bool_masked(mpx() .. "HEIST3TATTOOSTAT_BOOL1", true, 37)  --  Unlock for ZiT Aged Tee*
	stats.set_bool_masked(mpx() .. "HEIST3TATTOOSTAT_BOOL1", true, 44)  --  Unlock for Channel X Aged Tee
	stats.set_bool_masked(mpx() .. "HEIST3TATTOOSTAT_BOOL1", true, 45)  --  Unlock for Rebel Radio Aged Tee
	stats.set_bool_masked(mpx() .. "HEIST3TATTOOSTAT_BOOL1", true, 46)  --  Unlock for LSUR Aged Tee
	stats.set_bool_masked(mpx() .. "HEIST3TATTOOSTAT_BOOL1", true, 47)  --  Unlock for Steel Horse Solid Logo Aged Tee
	stats.set_bool_masked(mpx() .. "HEIST3TATTOOSTAT_BOOL1", true, 48)  --  Unlock for Black Western Logo Aged Tee
	stats.set_bool_masked(mpx() .. "HEIST3TATTOOSTAT_BOOL1", true, 49)  --  Unlock for White Nagasaki Aged Tee
	stats.set_bool_masked(mpx() .. "HEIST3TATTOOSTAT_BOOL1", true, 50)  --  Unlock for Black Principe Aged Tee
	stats.set_bool_masked(mpx() .. "HEIST3TATTOOSTAT_BOOL1", true, 51)  --  Unlock for Albany Vintage Aged Tee
	stats.set_bool_masked(mpx() .. "HEIST3TATTOOSTAT_BOOL1", true, 52)  --  Unlock for Benefactor Aged Tee
	stats.set_bool_masked(mpx() .. "HEIST3TATTOOSTAT_BOOL1", true, 53)  --  Unlock for Bravado Aged Tee
	stats.set_bool_masked(mpx() .. "HEIST3TATTOOSTAT_BOOL1", true, 54)  --  Unlock for Declasse Aged Tee
	stats.set_bool_masked(mpx() .. "HEIST3TATTOOSTAT_BOOL1", true, 55)  --  Unlock for Dinka Aged Tee
	stats.set_bool_masked(mpx() .. "HEIST3TATTOOSTAT_BOOL1", true, 56)  --  Unlock for Grotti Aged Tee
	stats.set_bool_masked(mpx() .. "HEIST3TATTOOSTAT_BOOL1", true, 57)  --  Unlock for Lampadati Aged Tee
	stats.set_bool_masked(mpx() .. "HEIST3TATTOOSTAT_BOOL1", true, 58)  --  Unlock for Ocelot Aged Tee
	stats.set_bool_masked(mpx() .. "HEIST3TATTOOSTAT_BOOL1", true, 59)  --  Unlock for Overflod Aged Tee
	stats.set_bool_masked(mpx() .. "SU20TATTOOSTAT_BOOL0", true, 0)  --  Unlock for Pegassi Aged Tee
	stats.set_bool_masked(mpx() .. "SU20TATTOOSTAT_BOOL0", true, 1)  --  Unlock for Pfister Aged Tee
	stats.set_bool_masked(mpx() .. "SU20TATTOOSTAT_BOOL0", true, 2)  --  Unlock for Vapid Aged Tee
	stats.set_bool_masked(mpx() .. "SU20TATTOOSTAT_BOOL0", true, 3)  --  Unlock for Weeny Aged Tee
	stats.set_bool_masked(mpx() .. "SU20TATTOOSTAT_BOOL0", true, 4)  --  Unlock for ToeShoes Aged T-Shirt
	stats.set_bool_masked(mpx() .. "SU20TATTOOSTAT_BOOL0", true, 5)  --  Unlock for Vanilla Unicorn Aged T-Shirt
	stats.set_bool_masked(mpx() .. "SU20TATTOOSTAT_BOOL0", true, 6)  --  Unlock for Fake Vapid Aged T-Shirt
	stats.set_bool_masked(mpx() .. "SU20TATTOOSTAT_BOOL0", true, 7)  --  Unlock for I Married My Dad Aged T-Shirt
	stats.set_bool_masked(mpx() .. "SU20TATTOOSTAT_BOOL0", true, 8)  --  Unlock for White Rockstar Camo Aged Tee
	stats.set_bool_masked(mpx() .. "SU20TATTOOSTAT_BOOL0", true, 9)  --  Unlock for Razor Aged T-Shirt
	stats.set_bool_masked(mpx() .. "SU20TATTOOSTAT_BOOL0", true, 10)  --  Unlock for Noise Rockstar Logo Aged Tee
	stats.set_bool_masked(mpx() .. "SU20TATTOOSTAT_BOOL0", true, 11)  --  Unlock for Noise Aged Tee
	stats.set_bool_masked(mpx() .. "SU20TATTOOSTAT_BOOL0", true, 12)  --  Unlock for Emotion 98.3 Aged T-Shirt
	stats.set_bool_masked(mpx() .. "SU20TATTOOSTAT_BOOL0", true, 13)  --  Unlock for KDST Aged T-Shirt
	stats.set_bool_masked(mpx() .. "SU20TATTOOSTAT_BOOL0", true, 14)  --  Unlock for KJAH Radio Aged T-Shirt
	stats.set_bool_masked(mpx() .. "SU20TATTOOSTAT_BOOL0", true, 15)  --  Unlock for Bounce FM Aged T-Shirt
	stats.set_bool_masked(mpx() .. "SU20TATTOOSTAT_BOOL0", true, 16)  --  Unlock for K-Rose Aged T-Shirt
	stats.set_bool_masked(mpx() .. "SU20TATTOOSTAT_BOOL0", true, 17)  --  Unlock for Blue The Diamond Resort LS Aged Tee
end)

CSYONS8:add_action("Unlock Rare Aged T-Shirts Boy", function()
	stats.set_bool_masked(mpx() .. "HEIST3TATTOOSTAT_BOOL0", true, 62)  --  Unlock for BCTR Aged Tee*
	stats.set_bool_masked(mpx() .. "HEIST3TATTOOSTAT_BOOL1", true, 0)  --  Unlock for Cultstopeprs Aged Tee*
	stats.set_bool_masked(mpx() .. "HEIST3TATTOOSTAT_BOOL1", true, 2)  --  Unlock for Daily Globe Aged Tee*
	stats.set_bool_masked(mpx() .. "HEIST3TATTOOSTAT_BOOL1", true, 4)  --  Unlock for Eyefind Aged Tee*
	stats.set_bool_masked(mpx() .. "HEIST3TATTOOSTAT_BOOL1", true, 6)  --  Unlock for Facade Aged Tee*
	stats.set_bool_masked(mpx() .. "HEIST3TATTOOSTAT_BOOL1", true, 8)  --  Unlock for Fruit Aged Tee*
	stats.set_bool_masked(mpx() .. "HEIST3TATTOOSTAT_BOOL1", true, 10)  --  Unlock for LSHH Aged Tee*
	stats.set_bool_masked(mpx() .. "HEIST3TATTOOSTAT_BOOL1", true, 12)  --  Unlock for MyRoom Aged Tee*
	stats.set_bool_masked(mpx() .. "HEIST3TATTOOSTAT_BOOL1", true, 14)  --  Unlock for Rebel Aged Tee*
	stats.set_bool_masked(mpx() .. "HEIST3TATTOOSTAT_BOOL1", true, 16)  --  Unlock for Six Figure Aged Tee*
	stats.set_bool_masked(mpx() .. "HEIST3TATTOOSTAT_BOOL1", true, 18)  --  Unlock for Trash Or Treasure Aged Tee*
	stats.set_bool_masked(mpx() .. "HEIST3TATTOOSTAT_BOOL1", true, 20)  --  Unlock for TW@ Logo Aged Tee*
	stats.set_bool_masked(mpx() .. "HEIST3TATTOOSTAT_BOOL1", true, 22)  --  Unlock for Vapers Den Aged Tee*
	stats.set_bool_masked(mpx() .. "HEIST3TATTOOSTAT_BOOL1", true, 24)  --  Unlock for WingIt Aged Tee*
	stats.set_bool_masked(mpx() .. "HEIST3TATTOOSTAT_BOOL1", true, 26)  --  Unlock for ZiT Aged Tee*
	stats.set_bool_masked(mpx() .. "HEIST3TATTOOSTAT_BOOL1", true, 33)  --  Unlock for Channel X Aged Tee
	stats.set_bool_masked(mpx() .. "HEIST3TATTOOSTAT_BOOL1", true, 34)  --  Unlock for Rebel Radio Aged Tee
	stats.set_bool_masked(mpx() .. "HEIST3TATTOOSTAT_BOOL1", true, 35)  --  Unlock for LSUR Aged Tee
	stats.set_bool_masked(mpx() .. "HEIST3TATTOOSTAT_BOOL1", true, 36)  --  Unlock for Steel Horse Solid Logo Aged Tee
	stats.set_bool_masked(mpx() .. "HEIST3TATTOOSTAT_BOOL1", true, 37)  --  Unlock for Black Western Logo Aged Tee
	stats.set_bool_masked(mpx() .. "HEIST3TATTOOSTAT_BOOL1", true, 38)  --  Unlock for White Nagasaki Aged Tee
	stats.set_bool_masked(mpx() .. "HEIST3TATTOOSTAT_BOOL1", true, 39)  --  Unlock for Black Principe Aged Tee
	stats.set_bool_masked(mpx() .. "HEIST3TATTOOSTAT_BOOL1", true, 40)  --  Unlock for Albany Vintage Aged Tee
	stats.set_bool_masked(mpx() .. "HEIST3TATTOOSTAT_BOOL1", true, 41)  --  Unlock for Benefactor Aged Tee
	stats.set_bool_masked(mpx() .. "HEIST3TATTOOSTAT_BOOL1", true, 42)  --  Unlock for Bravado Aged Tee
	stats.set_bool_masked(mpx() .. "HEIST3TATTOOSTAT_BOOL1", true, 43)  --  Unlock for Declasse Aged Tee
	stats.set_bool_masked(mpx() .. "HEIST3TATTOOSTAT_BOOL1", true, 44)  --  Unlock for Dinka Aged Tee
	stats.set_bool_masked(mpx() .. "HEIST3TATTOOSTAT_BOOL1", true, 45)  --  Unlock for Grotti Aged Tee
	stats.set_bool_masked(mpx() .. "HEIST3TATTOOSTAT_BOOL1", true, 46)  --  Unlock for Lampadati Aged Tee
	stats.set_bool_masked(mpx() .. "HEIST3TATTOOSTAT_BOOL1", true, 47)  --  Unlock for Ocelot Aged Tee
	stats.set_bool_masked(mpx() .. "HEIST3TATTOOSTAT_BOOL1", true, 48)  --  Unlock for Overflod Aged Tee
	stats.set_bool_masked(mpx() .. "HEIST3TATTOOSTAT_BOOL1", true, 49)  --  Unlock for Pegassi Aged Tee
	stats.set_bool_masked(mpx() .. "HEIST3TATTOOSTAT_BOOL1", true, 50)  --  Unlock for Pfister Aged Tee
	stats.set_bool_masked(mpx() .. "HEIST3TATTOOSTAT_BOOL1", true, 51)  --  Unlock for Vapid Aged Tee
	stats.set_bool_masked(mpx() .. "HEIST3TATTOOSTAT_BOOL1", true, 52)  --  Unlock for Weeny Aged Tee
	stats.set_bool_masked(mpx() .. "HEIST3TATTOOSTAT_BOOL1", true, 53)  --  Unlock for ToeShoes Aged T-Shirt
	stats.set_bool_masked(mpx() .. "HEIST3TATTOOSTAT_BOOL1", true, 54)  --  Unlock for Vanilla Unicorn Aged T-Shirt
	stats.set_bool_masked(mpx() .. "HEIST3TATTOOSTAT_BOOL1", true, 55)  --  Unlock for Fake Vapid Aged T-Shirt
	stats.set_bool_masked(mpx() .. "HEIST3TATTOOSTAT_BOOL1", true, 56)  --  Unlock for I Married My Dad Aged T-Shirt
	stats.set_bool_masked(mpx() .. "HEIST3TATTOOSTAT_BOOL1", true, 57)  --  Unlock for White Rockstar Camo Aged Tee
	stats.set_bool_masked(mpx() .. "HEIST3TATTOOSTAT_BOOL1", true, 58)  --  Unlock for Razor Aged T-Shirt
	stats.set_bool_masked(mpx() .. "HEIST3TATTOOSTAT_BOOL1", true, 59)  --  Unlock for Noise Rockstar Logo Aged Tee
	stats.set_bool_masked(mpx() .. "SU20TATTOOSTAT_BOOL0", true, 0)  --  Unlock for Noise Aged Tee
	stats.set_bool_masked(mpx() .. "SU20TATTOOSTAT_BOOL0", true, 1)  --  Unlock for Emotion 98.3 Aged T-Shirt
	stats.set_bool_masked(mpx() .. "SU20TATTOOSTAT_BOOL0", true, 2)  --  Unlock for KDST Aged T-Shirt
	stats.set_bool_masked(mpx() .. "SU20TATTOOSTAT_BOOL0", true, 3)  --  Unlock for KJAH Radio Aged T-Shirt
	stats.set_bool_masked(mpx() .. "SU20TATTOOSTAT_BOOL0", true, 4)  --  Unlock for Bounce FM Aged T-Shirt
	stats.set_bool_masked(mpx() .. "SU20TATTOOSTAT_BOOL0", true, 5)  --  Unlock for K-Rose Aged T-Shirt
	stats.set_bool_masked(mpx() .. "SU20TATTOOSTAT_BOOL0", true, 6)  --  Unlock for Blue The Diamond Resort LS Aged Tee
end)

CSYONS2:add_action("Thank to Shiny Wasabi Kitty Claw", function() ahc() end)
ahc() --will run function on scripts reload or menu launch

CSYONS2:add_action("Refill Inventory & Armour", function()	stats.set_int(mpx .. "NO_BOUGHT_YUM_SNACKS", 30) stats.set_int(mpx .. "NO_BOUGHT_HEALTH_SNACKS", 15) stats.set_int(mpx .. "NO_BOUGHT_EPIC_SNACKS", 5) stats.set_int(mpx .. "NUMBER_OF_CHAMP_BOUGHT", 5) stats.set_int(mpx .. "NUMBER_OF_ORANGE_BOUGHT", 11) stats.set_int(mpx .. "NUMBER_OF_BOURGE_BOUGHT", 10) stats.set_int(mpx .. "CIGARETTES_BOUGHT", 20) stats.set_int(mpx .. "MP_CHAR_ARMOUR_1_COUNT", 10) stats.set_int(mpx .. "MP_CHAR_ARMOUR_2_COUNT", 10) stats.set_int(mpx .. "MP_CHAR_ARMOUR_3_COUNT", 10) stats.set_int(mpx .. "MP_CHAR_ARMOUR_4_COUNT", 10) stats.set_int(mpx .. "MP_CHAR_ARMOUR_5_COUNT", 10) stats.set_int(mpx .. "BREATHING_APPAR_BOUGHT", 20) end) 
CSYONS8:add_action("Fast Run & Reload", function() stats.set_int(mpx .. "CHAR_ABILITY_1_UNLCK", -1) stats.set_int(mpx .. "CHAR_ABILITY_2_UNLCK", -1) stats.set_int(mpx .. "CHAR_ABILITY_3_UNLCK", -1) stats.set_int(mpx .. "CHAR_FM_ABILITY_1_UNLCK", -1) stats.set_int(mpx .. "CHAR_FM_ABILITY_2_UNLCK", -1) stats.set_int(mpx .. "CHAR_FM_ABILITY_3_UNLCK", -1) globals.set_int(1575015, 1) globals.set_int(1574589, 1) sleep(0.2) globals.set_int(1574589, 0) end) 
CSYONS8:add_action("Reset Fast Run & Reload", function() stats.set_int(mpx .. "CHAR_ABILITY_1_UNLCK", 0) stats.set_int(mpx .. "CHAR_ABILITY_2_UNLCK", 0) stats.set_int(mpx .. "CHAR_ABILITY_3_UNLCK", 0) stats.set_int(mpx .. "CHAR_FM_ABILITY_1_UNLCK", 0) stats.set_int(mpx .. "CHAR_FM_ABILITY_2_UNLCK", 0) stats.set_int(mpx .. "CHAR_FM_ABILITY_3_UNLCK", 0) globals.set_int(1575015, 1) globals.set_int(1574589, 1) sleep(0.2) globals.set_int(1574589, 0) end)

function fx() globals.set_bool(1669394 + 792, true) globals.set_bool(1669394 + 504, true) end
fx() menu.register_callback('OnPlayerChanged', fx)

--menu.register_callback('OnPlayerChanged', function()
  --  globals.set_bool(1669394 + 792, true)
    --globals.set_bool(1669394 + 504, true)
--end)

CSYONS8:add_action("Unlock stuff hidden behind packed bools", function()
	for i = 0, 63 do
		stats.set_bool_masked(MPx().."DLC22022PSTAT_BOOL1", true, i)
		stats.set_bool_masked(MPx().."DLC22022PSTAT_BOOL2", true, i)
		stats.set_bool_masked(MPx().."DLC22022PSTAT_BOOL", true, i)
		stats.set_bool_masked(36788,true, -1, mpx())
		stats.set_int(MPx().."DLC22022PSTAT_INT"..i, 1)
		
	end
end)

CSYONS2:add_action("Revive All Dead Cars", function()
    for v in replayinterface.get_vehicles() do
        if v ~= nil then
            v:set_health(1000)
        end
    end
end)

-----
Spawner= CSYONS5:add_submenu("Vehicles Spawner")

RS = Spawner:add_submenu("Request Services")

CSYONS5:add_action("Spawn Avenger", function() menu.deliver_avenger() end)
CSYONS5:add_action("Spawn Kosatska", function() menu.deliver_kosatka() end)
CSYONS5:add_action("Spawn Mobile Command Center", function() menu.deliver_moc() end)
CSYONS5:add_action("Spawn Terrorbyte", function() menu.deliver_terrorbyte() end)

RS3 = Spawner:add_submenu("Kosatka Vehicle")

CSYONS5:add_action("Deliver Kosatka Avisa Submarine", function() menu.deliver_avisa() end)
CSYONS5:add_action("Deliver Kosatka Dinghy", function() menu.deliver_dinghy() end)
CSYONS5:add_action("Deliver Kostaka Sea Sparrow", function() menu.deliver_seasparrow() end)


a={}a[joaat("BOOR")]="Karin Boor"
a[joaat("BRICKADE2")]="MTL Brickade 6x6"
a[joaat("BROADWAY")]="Classique Broadway"
a[joaat("EUDORA")]="Willard Eudora"
a[joaat("EVERON2")]="Karin Hotring Everon"
a[joaat("ISSI8")]="Weeny Issi Rally"
a[joaat("PANTHERE")]="Toundra Panthere"
a[joaat("POWERSURGE")]="Western Powersurge"
a[joaat("TAHOMA")]="Declasse Tahoma Coupe"
a[joaat("VIRTUE")]="Ocelot Virtue"local 
b={}b[joaat("BOOR")]=33972;
b[joaat("BRICKADE2")]=33962;
b[joaat("BROADWAY")]=33967;
b[joaat("EUDORA")]=33971;
b[joaat("EVERON2")]=33969;
b[joaat("ISSI8")]=33966;
b[joaat("PANTHERE")]=33968;
b[joaat("POWERSURGE")]=33965;
b[joaat("TAHOMA")]=33964;
b[joaat("VIRTUE")]=33970;
function SpawnVehicle(c)local d=b[c]globals.set_int(262145+d,1)
	local e=localplayer:get_position()local 
	f=localplayer:get_heading()e.x=e.x+f.x*5;e.y=e.y+f.y*5;globals.set_int(2639783+46,c)globals.set_float(2639783+42,e.x)globals.set_float(2639783+43,e.y)globals.set_float(2639783+44,e.z)globals.set_boolean(2639783+41,true)end;local g=Spawner:add_submenu("Los Santos Drug Wars")for h,i in pairs(a)do g:add_action(i,function()SpawnVehicle(h)end)end


CSYONS5 = CSYON5:add_submenu("Wheels Mod Section")

F1Mod = false
OldF1Hash = 0
CSYONS5:add_toggle("F1 - Covers", function()
	return F1Mod
end, function()
	F1Mod = not F1Mod
	if F1Mod then
		if localplayer ~= nil then
			if localplayer:is_in_vehicle() then
				OldF1Hash = localplayer:get_current_vehicle():get_model_hash()
				localplayer:get_current_vehicle():set_model_hash(1492612435)
			end
		end
	else
		if localplayer ~= nil then
			if localplayer:is_in_vehicle() then
				localplayer:get_current_vehicle():set_model_hash(OldF1Hash)
			end
		end
	end
end)

BennyMod = false
OldBennyHash = 0
CSYONS5:add_toggle("Bennys - Covers", function()
	return BennyMod
end, function()
	BennyMod = not BennyMod
	if BennyMod then
		if localplayer ~= nil then
			if localplayer:is_in_vehicle() then
				OldBennyHash = localplayer:get_current_vehicle():get_model_hash()
				localplayer:get_current_vehicle():set_model_hash(196747873)
			end
		end
	else
		if localplayer ~= nil then
			if localplayer:is_in_vehicle() then
				localplayer:get_current_vehicle():set_model_hash(OldBennyHash)
			end
		end
	end
end)

CSYONS5 = CSYON5:add_submenu("Custom Plate")

PlateChar = {"0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", ""}
PI1 = PlateChar[1]
PI1Current = 1
CSYONS5:add_array_item("Char #1", PlateChar, function()
	if localplayer ~= nil and localplayer:is_in_vehicle() then
		return PI1Current
	end
end, function(value)
	PI1 = PlateChar[value]
	PI1Current = value
end)


PI2 = PlateChar[1]
PI2Current = 1
CSYONS5:add_array_item("Char #2", PlateChar, function()
	if localplayer ~= nil and localplayer:is_in_vehicle() then
		return PI2Current
	end
end, function(value)
	PI2 = PlateChar[value]
	PI2Current = value
end)


PI3 = PlateChar[1]
PI3Current = 1
CSYONS5:add_array_item("Char #3", PlateChar, function()
	if localplayer ~= nil and localplayer:is_in_vehicle() then
		return PI3Current
	end
end, function(value)
	PI3 = PlateChar[value]
	PI3Current = value
end)


PI4 = PlateChar[1]
PI4Current = 1
CSYONS5:add_array_item("Char #4", PlateChar, function()
	if localplayer ~= nil and localplayer:is_in_vehicle() then
		return PI4Current
	end
end, function(value)
	PI4 = PlateChar[value]
	PI4Current = value
end)


PI5 = PlateChar[1]
PI5Current = 1
CSYONS5:add_array_item("Char #5", PlateChar, function()
	if localplayer ~= nil and localplayer:is_in_vehicle() then
		return PI5Current
	end
end, function(value)
	PI5 = PlateChar[value]
	PI5Current = value
end)


PI6 = PlateChar[1]
PI6Current = 1
CSYONS5:add_array_item("Char #6", PlateChar, function()
	if localplayer ~= nil and localplayer:is_in_vehicle() then
		return PI6Current
	end
end, function(value)
	PI6 = PlateChar[value]
	PI6Current = value
end)


PI7 = PlateChar[1]
PI7Current = 1
CSYONS5:add_array_item("Char #7", PlateChar, function()
	if localplayer ~= nil and localplayer:is_in_vehicle() then
		return PI7Current
	end
end, function(value)
	PI7 = PlateChar[value]
	PI7Current = value
end)


PI8 = PlateChar[1]
PI8Current = 1
CSYONS5:add_array_item("Char #8", PlateChar, function()
	if localplayer ~= nil and localplayer:is_in_vehicle() then
		return PI8Current
	end
end, function(value)
	PI8 = PlateChar[value]
	PI8Current = value
end)


CSYONS5:add_bare_item("", function()
	return "Apply plate: " .. PI1 .. PI2 .. PI3 .. PI4 .. PI5 .. PI6 .. PI7 .. PI8
end, function()
	if localplayer ~= nil and localplayer:is_in_vehicle() then
		localplayer:get_current_vehicle():set_number_plate_text(PI1 .. PI2 .. PI3 .. PI4 .. PI5 .. PI6 .. PI7 .. PI8)
	end
end, function()
end, function()
end)


CSYONS5 = CSYON5:add_submenu("Car Speed Menu")
local function superChargeVehicle()
	if localplayer == nil then
		return
	end
	
	current_vehicle = localplayer:get_current_vehicle()
		if current_vehicle ~= nil then
			current_vehicle:set_acceleration(1.59)
			current_vehicle:set_gravity(16.8)

		end
end
CSYONS5:add_action("Active Car Speed Hack", superChargeVehicle)
-----

fdGlobal = 262145+33900--First Dose Hard Mode
function mp() return "mp"..stats.get_int("MPPLY_LAST_MP_CHAR").."_" end
CSYONS2:add_array_item("Play ", {"1 - Welcome to the Troupe", "2 - Designated Driver", "3 - Fatal Incursion", "4 - Uncontrolled Substance", "5 - Make War not Love", "6 - Off the Rails"}, function() return stats.get_int(mp().."XM22_CURRENT")+1 end, function(m) stats.set_int(mp().."XM22_CURRENT",m-1) end)
CSYONS2:add_toggle("Hard Mode", function() return globals.get_boolean(fdGlobal) end, function(b) globals.set_boolean(fdGlobal,b) end)
CSYONS5:add_action("have fun By CSYON", function() end)

CSYONS9:add_toggle("Nightclub Safe Abuse $250k/10s (AFK)",
    function()
        return night
    end,
    function()
        night = not night
        clubs(night)
    end
)

CSYONS8:add_action("Unlock 1.64 Clothes",
    function()
        DrugWarsUnlockClothes_CSYON()
    end
)

CSYONS8:add_action("Unlock StreetDealer",
    function()
        StreetDealer_CSYON()
    end
)
	 
CSYONS2:add_action("Cayo Fingerprint Clone", function()
    if(script(script_name):is_active()) then
        script(script_name):set_int(cayo_fingerprint_clone, 5)
    end
end)

CSYONS2:add_action("Unlock 1.64 Baseball Bat & Knife Design",
    function()
        Baseball_Bat_and_Knife_liveries_CSYON()
    end
)

CSYONS8:add_action("Unlock Eclipse 50Slots Garage",
     function()
         unlockBLVDGarage_CSYON()
     end
)
 
CSYONS2:add_action("Cayo Instant Heist Passed", function()
    if(script(script_name):is_active()) then
        script(script_name):set_int(cayo_instant_heist_passed_trigger, 9)
        script(script_name):set_int(cayo_instant_heist_passed_value, 50)
    end
end)
	 
	CSYONS8:add_int_range("XMAS Mugger Event(Gooch)", 171, 0, 171, function() 
    	return globals.get_int(2756259+3+1)
    end, function(value)
    	globals.set_int(2756259+3+1, value)
		globals.set_int(2756259+2, 6)
    end)
	
CSYONS2:add_int_range("Bank Shootout Event",  172, 0, 172, function() 
    	return globals.get_int(2756259+3+1)
    end, function(value)
        globals.set_int(262145+34058, 1) -- ENABLE_MAZEBANKSHOOTOUT_DLC22022
    	globals.set_int(2756259+3+1, value)
		globals.set_int(2756259+2, 6)
    end)

CSYONS8:add_action("LSCM Prize Ride Unlock", function() stats.set_bool(mpx .. "CARMEET_PV_CHLLGE_CMPLT", true) end)

CSYONS8:add_action("Unlock LSCM Rep Lvl 1000", function() for i = 293761, 293788 do globals.set_float(i, 100000) end end)

CSYONS2:add_action("Set Agency security missions to 500", function()
    local PlayerIndex = stats.get_int("MPPLY_LAST_MP_CHAR")
    local MPX = PlayerIndex
    if PlayerIndex == 0 then MPX = "MP0_" else MPX = "MP1_" end
    stats.set_int(MPX .. "FIXER_COUNT", 500)
end)

CSYONS2:add_int_range("Remove Kosatka Missle Cooldown", 10000, 0, 2147483647, function()
	return globals.get_int(262145 + 30175) 
end, function(value)
	globals.set_int(262145 + 30175, value)
end)
 
CSYONS2:add_int_range("Increase Kosatka Missile Range", 1000, 0, 2147483647, function()
	return globals.get_int(262145 + 30176) 
end, function(value)
	globals.set_int(262145 + 30176, value)
end)

CSYONS2:add_action("New Sessanta Vehicle", function()
	local shop_controller = script("shop_controller")
	if shop_controller and shop_controller:is_active() then
		stats.set_int("MP" .. stats.get_int("MPPLY_LAST_MP_CHAR") .. "_TUNER_CLIENT_VEHICLE_POSSIX", 1)
		base_local = 297
		-- this base_local value is current as of v1.63, 2-Nov-22, per Underd0g. note that these offsets shift slightly every update
		shop_controller:set_int(base_local + 1, 0)
		shop_controller:set_int(base_local + 2, 0)
		shop_controller:set_int(base_local + 3, 1)
		shop_controller:set_int(base_local, 3)
	end
end, function()
	return script("shop_controller"):is_active()
end)

CSYONS5:add_toggle("Horn E",function()return Horn end,function(v)
	Horn=v if v then menu.send_key_down(69)else menu.send_key_up(69)end end)

CSYONS4:add_toggle("FastFire-Atomizer,StunGun", function() return enable end, function()
	enable=not enable if enable then csyon=menu.register_callback('OnWeaponChanged', OnWeaponChanged)else menu.remove_callback(csyon) bT,WR,LR=0,0,0 end
end)

CSYONS2:add_action("Royals, Lucky 7s and Alien Tattoo", function()
	for i = 0, 63 do
		for z = 0, 05 do
			stats.set_bool_masked("MP" .. mpx() .. "_GUNTATPSTAT_BOOL" .. z, true, i, mpx)
		end
	end
end)

CSYONS4:add_action("Weapon Damage Hotkeynum7", weaponDamage)
menu.register_hotkey(103, weaponDamage)
--Press num7 to Weapon Damage

local cars_data = {}
local function waitForVehicleData()
	local tries = 0
	while tries <= 250 do
		-- try getting a vehicle and its handling data
		veh = localplayer:get_current_vehicle()
		local temp_data = {
					veh:get_acceleration(),			--1
					veh:get_brake_force(),			--2
					veh:get_gravity(),				--3
					veh:get_handbrake_force(),		--4
					veh:get_initial_drive_force(),	--5
					veh:get_traction_curve_min(),	--6
					veh:get_traction_curve_max(),	--7
					veh:get_traction_bias_front(),	--8
					veh:get_up_shift(),				--9
					veh:get_down_shift(),			--10
					veh:get_initial_drive_max_flat_velocity(),	--11
					veh:get_centre_of_mass_offset(),			--12
					veh:get_collision_damage_multiplier(),		--13
					veh:get_engine_damage_multiplier(),			--14
					veh:get_roll_centre_height_front(),			--15	
					veh:get_roll_centre_height_rear(),			--16
					veh:get_drive_bias_front(),					--17
					veh:get_traction_loss_multiplier(),			--18
					veh:get_initial_drag_coeff()				--19
					}
		
		--do a rough check if the vehicle data we got actually makes sense, else try getting the vehicle object again
		--this is to work around a bug in Kiddions LUA vehicle implementation where often
		--the vehicle handling data in a vehicle object will be broken, leaving to bs data when using get methods
		--and being unable to change the handling later with set methods
		--once we find a working veh object, it gets saved in the table and returned so it can be used to modify on later
		if (temp_data[8] >= 0 and temp_data[8] <= 1) and
		   (temp_data[11] >= 10 and temp_data[11] <= 500) and
		   (temp_data[17] >= 0 and temp_data[17] <= 1) then
		    -- save the working veh object with model hash as key in the table so we can use it later
			temp_data[veh:get_model_hash()] = veh
			return temp_data
		end
		--try again if the data we got looked weird
		sleep(0.02)
		tries = tries + 1
	end
end
 
local function boostVehicle(vehicle_data, boost)
	if boost then --boost mode
		accel = vehicle_data[1] * 20
		brake_force = vehicle_data[2] * 23
		gravity = 19.7
		handbrake_force = vehicle_data[4] * 14
		initial_drive_force = vehicle_data[5] * 690   --nice
		traction_min = 8   --very high traction. Used without roll_centre modification, the car will constantly flip
		traction_max = vehicle_data[7] + 2
		traction_bias_front = 0.420
		up_shift = 10000  --huge shift values, causing cars to get stuck in gear and accelerate rapidly
		down_shift = 10000
		max_flat_vel = 10000
		mass_offset = vector3(0,2,1)  --puts the centre of mass up and in front of the car, making it more stable
		collision_dmg_multiplier = 0
		engine_dmg_multiplier = 0
		roll_centre_front = vehicle_data[15] + 0.320  --these two stop the car from rolling even at high speeds, it rolls inwards instead
		roll_centre_rear = vehicle_data[16] + 0.320
		drive_bias = 0.5   --all wheel drive
		traction_loss_mult = 1
		initial_drag_coeff = 1  --no drag forces
	else --restore mode
		accel = vehicle_data[1]
		brake_force = vehicle_data[2]
		gravity = vehicle_data[3]
		handbrake_force = vehicle_data[4]
		initial_drive_force = vehicle_data[5]
		traction_min = vehicle_data[6]
		traction_max = vehicle_data[7]
		traction_bias_front = vehicle_data[8]
		up_shift = vehicle_data[9]
		down_shift = vehicle_data[10]
		max_flat_vel = vehicle_data[11]
		mass_offset = vehicle_data[12]
		collision_dmg_multiplier = vehicle_data[13]
		engine_dmg_multiplier = vehicle_data[14]
		roll_centre_front = vehicle_data[15]
		roll_centre_rear = vehicle_data[16]
		drive_bias = vehicle_data[17]
		traction_loss_mult = vehicle_data[18]
		initial_drag_coeff = vehicle_data[19]
	end
	
	vehicle = vehicle_data[localplayer:get_current_vehicle():get_model_hash()]
	vehicle:set_acceleration(accel)
	vehicle:set_brake_force(brake_force)
	vehicle:set_gravity(gravity)
	vehicle:set_handbrake_force(handbrake_force)
	vehicle:set_initial_drive_force(initial_drive_force)
	vehicle:set_traction_curve_min(traction_min)
	vehicle:set_traction_curve_max(traction_max)
	vehicle:set_traction_bias_front(traction_bias_front)
	vehicle:set_up_shift(up_shift)
	vehicle:set_down_shift(down_shift)
	vehicle:set_initial_drive_max_flat_velocity(max_flat_vel)
	vehicle:set_centre_of_mass_offset(mass_offset)
	vehicle:set_roll_centre_height_front(roll_centre_front)
	vehicle:set_roll_centre_height_rear(roll_centre_rear)
	vehicle:set_drive_bias_front(drive_bias)
	vehicle:set_collision_damage_multiplier(collision_dmg_multiplier)
	vehicle:set_engine_damage_multiplier(engine_dmg_multiplier)
	vehicle:set_traction_loss_multiplier(traction_loss_mult)
	vehicle:set_initial_drag_coeff(initial_drag_coeff)
	vehicle:set_max_speed(10000)
end
 
local function reloadVehicle(vehicle)
	--Check if car has been found in the table, then restore, otherwise exit
	restore = cars_data[vehicle:get_model_hash()]
	if restore then
		boostVehicle(restore, false)
	end
end
 
--------------------------------
--boosted car handling logic, insert key
--------------------------------
function carBoost()
	if localplayer ~= nil and localplayer:is_in_vehicle() then 
		current = localplayer:get_current_vehicle()
		if current == nil then return end
 
		--check if car has been modified already by the modified gravity value, if not, try to save and modify it
		if current:get_gravity() ~= 19.7 then
		
			
			--Save car data to map if it's not in there already
			if not cars_data[current:get_model_hash()] then
				local car_data = waitForVehicleData(current)
				if car_data then
					cars_data[current:get_model_hash()] = car_data
				else
					--if waitForVehicleData didn't return anything, we didn't find the right vehicle object, so exit
					return
				end
			end
			
			--boost car if data has been read successfully
			::boost::
			boostVehicle(cars_data[current:get_model_hash()], true)
			
			--Check if the boost worked, else reload the vehicle object again and try once more
			--This is usually necessary when changing to a new car of the same type, or when the old one gets destroyed and called back
			if current:get_gravity() ~= 19.7 then
				reloadVehicle(current)
				local car_data = waitForVehicleData(current)
				if car_data then
					cars_data[current:get_model_hash()] = car_data
					goto boost
				else
					--if waitForVehicleData didn't return anything, we didn't find the right vehicle object, so exit
					return
				end
			end
		else
			reloadVehicle(current)
		end
	end
end
 
menu.register_hotkey(45, carBoost) --Insrt key
 
CSYONS2:add_action("Drop Ped", PedDrop)

local enable = false
local speed = 2
local function up()
	if not enable then return end
	local newpos = localplayer:get_position() + vector3(0,0,speed)
 
	if not localplayer:is_in_vehicle() then
		localplayer:set_position(newpos)
	else
		vehicle=localplayer:get_current_vehicle()
		vehicle:set_position(newpos)
	end
end
 
local function down()
	if not enable then return end
	local newpos = localplayer:get_position() + vector3(0,0,speed * -1)
 
	if not localplayer:is_in_vehicle() then
		localplayer:set_position(newpos)
	else
		vehicle=localplayer:get_current_vehicle()
		vehicle:set_position(newpos)
	end
end
 
local function forward()
	if not enable then return end
	local dir = localplayer:get_heading()
	local newpos = localplayer:get_position() + (dir * speed)
 
	if not localplayer:is_in_vehicle() then
		localplayer:set_position(newpos)
	else
		vehicle=localplayer:get_current_vehicle()
		vehicle:set_position(newpos)
	end
end
 
local function backward()
	if not enable then return end
	local dir = localplayer:get_heading()
	local newpos = localplayer:get_position() + (dir * speed * -1)
 
	if not localplayer:is_in_vehicle() then
		localplayer:set_position(newpos)
	else
		vehicle=localplayer:get_current_vehicle()
		vehicle:set_position(newpos)
	end
end
 
local function turnleft()
	if not enable then return end
	local dir = localplayer:get_rotation()
	
	if not localplayer:is_in_vehicle() then
		localplayer:set_rotation(dir + vector3(0.25,0,0))
	else
		vehicle=localplayer:get_current_vehicle()
		vehicle:set_rotation(dir + vector3(0.25,0,0))
	end
end
 
local function turnright()
	if not enable then return end
	local dir = localplayer:get_rotation()
	
	if not localplayer:is_in_vehicle() then
		localplayer:set_rotation(dir + vector3(0.25 * -1,0,0))
	else
		vehicle=localplayer:get_current_vehicle()
		vehicle:set_rotation(dir + vector3(0.25 * -1,0,0))
	end
end
 
local function increasespeed()
	if speed > 0 then 
		speed = speed + 1
	end
end
 
local function decreasespeed()
	if speed > 1 then 
		speed = speed - 1
	end
end
 
local up_hotkey
local down_hotkey
local forward_hotkey
local backward_hotkey
local turnleft_hotkey
local turnright_hotkey
local increasespeed_hotkey
local decreasespeed_hotkey
 
local function NoClip(e)
	if not localplayer then return end
	if e then 
		localplayer:set_freeze_momentum(true) 
		localplayer:set_no_ragdoll(true)
		localplayer:set_config_flag(292,true)
		up_hotkey = menu.register_hotkey(16, up)
		down_hotkey = menu.register_hotkey(17, down)
		forward_hotkey = menu.register_hotkey(38, forward)
		backward_hotkey = menu.register_hotkey(40, backward)
		turnleft_hotkey = menu.register_hotkey(37, turnleft)
		turnright_hotkey = menu.register_hotkey(39, turnright)
		increasespeed_hotkey = menu.register_hotkey(107, increasespeed)
		decreasespeed_hotkey = menu.register_hotkey(109, decreasespeed)
	else
		localplayer:set_freeze_momentum(false)
		localplayer:set_no_ragdoll(false)
		localplayer:set_config_flag(292,false)
		menu.remove_hotkey(up_hotkey)
		menu.remove_hotkey(down_hotkey)
		menu.remove_hotkey(forward_hotkey)
		menu.remove_hotkey(backward_hotkey)
		menu.remove_hotkey(turnleft_hotkey)
		menu.remove_hotkey(turnright_hotkey)
		menu.remove_hotkey(increasespeed_hotkey)
		menu.remove_hotkey(decreasespeed_hotkey)
	end
end
 
menu.register_hotkey(111, function()
	enable = not enable 
	NoClip(enable)
end)
 
CSYONS7:add_toggle("NoClip", function()
	return enable
end, function()
	enable = not enable 
	NoClip(enable)
end)
 
CSYONS7:add_int_range("NoClip Speed", 1, 1, 10, function()
	return speed
end, function(i) speed = i end)

--Protect him
CSYONS6:add_toggle("Actived All", function()
	return boolall
end, function()
	boolall = not boolall
	All(boolall)
	
end)

CSYONS6:add_toggle("Block Some Kicks&&Crashes", function()
	return boolskc
end, function()
	boolskc = not bboolskc
	KickCrashes(boolskc)
	
end)
CSYONS6:add_toggle("Block Sound Spam", function()
	return boolsps
end, function()
	boolsps = not boolsps
	SoundSpam(boolsps)
	
end)
 
CSYONS6:add_toggle("Block Infinite Loadingscreen", function()
	return boolil
end, function()
	boolil = not boolil
	InfiniteLoad(boolil)
	
end)
 
CSYONS6:add_toggle("Block Passive Mode", function()
	return boolb
end, function()
	boolb = not boolb
	PassiveMode(boolb)
	
end)
 
CSYONS6:add_toggle("Block Transaction Error", function()
	return boolte
end, function()
	boolte = not boolte
	TransactionError(boolte)
	
end)
 
CSYONS6:add_toggle("Block Modded Notifys/SMS", function()
	return boolrm
end, function()
	boolrm = not boolrm
	RemoveMoneyMessage(boolrm)
	
end)
 
CSYONS6:add_toggle("Block Clear Wanted", function()
	return boolclw
end, function()
	boolclw = not boolclw
	ClearWanted(boolclw)
	
end)
 
CSYONS6:add_toggle("Block Off The Radar", function()
	return boolotr
end, function()
	boolotr = not boolotr
	OffTheRadar(boolotr)
	
end)
 
CSYONS6:add_toggle("Block Personal Vehicle Destroy", function()
	return boolpvd
end, function()
	boolpvd = not boolpvd
	PersonalVehicleDestroy(boolpvd)
	
end)
 
CSYONS6:add_toggle("Block Send to Cutscene", function()
	return boolstc
end, function()
	boolstc = not boolstc
	SendCutscene(boolstc)
	
end)
 
CSYONS6:add_toggle("Block Remove Godmode", function()
	return boolgod
end, function()
	boolgod = not boolgod
	Godmode(boolgod)
	
end)
 
CSYONS6:add_toggle("Block Give Collectibles", function()
	return boolgc
end, function()
	boolgc = not boolgc
	Collectibles(boolgc)
	
end)
 
CSYONS6:add_toggle("Block Cayo && Beach Teleport", function()
	return boolcbt
end, function()
	boolcbt = not boolcbt
	ExtraTeleport(boolcbt)
	
end)
 
CSYONS6:add_toggle("Block Bounty", function()
	return boolbou
end, function()
	boolbou = not boolbou
	Bounty(boolbou)
	
end)
--Protections

CSYONS2:add_action("Make Nightclub Popular (\u{26A0}Risky)", function()
	mpIndex = globals.get_int(1574907)
	if mpIndex == 0 then
		stats.set_int("mp0_club_popularity", 1000)
	else
		stats.set_int("mp1_club_popularity", 1000)
	end
end)

menu.register_hotkey(110, function()
	if localplayer ~= nil and localplayer:is_in_vehicle() then 
		vehicle = localplayer:get_current_vehicle()
		grav = vehicle:get_gravity()
		vehicle:set_gravity(-50)
		sleep(0.2)
		vehicle:set_gravity(grav)
	end
end)

CSYONS5:add_action("Heal Vehicle", function()
	if localplayer == nil then
		return
	end
	
	current_vehicle = localplayer:get_current_vehicle()
	if current_vehicle ~= nil then
		if current_vehicle:get_health() < 1000 then
			current_vehicle:set_health(1000)
		end
	end
end)

local heal_vehicle_on_change = false
CSYONS5:add_toggle("Heal Vehicle on Change", function() 
	return heal_vehicle_on_change 
end, function(value)
	heal_vehicle_on_change = value
end)
 
local function OnVehicleChanged(oldVehicle, newVehicle)
	if newVehicle ~= nil and heal_vehicle_on_change then
		if newVehicle:get_health() < 1000 then
			newVehicle:set_health(1000)
		end
	end
end
 
menu.register_callback('OnVehicleChanged', OnVehicleChanged)
 
CSYONS2:add_toggle("Snow HotkeyF12", function()
    return globals.get_boolean(snowAddress)
end, toggleSnow)
 
menu.register_hotkey(123, toggleSnow) -- F12

local casinoFinger=52962
CSYONS2:add_action("Crack Casino Fingerprint", function()
	local heist_script = script("fm_mission_controller")
	if heist_script and heist_script:is_active() then
		if heist_script:get_int(casinoFinger) == 3 or heist_script:get_int(casinoFinger) == 4 then
			heist_script:set_int(casinoFinger, 5)
		end
	end
end)

local cayoFinger=22032
CSYONS2:add_action("Crack Cayo FingerPrint Scan", function()
	local heist_script = script("fm_mission_controller_2020")
	if heist_script and heist_script:is_active() then
		if heist_script:get_int(cayoFinger) == 4 then
			heist_script:set_int(cayoFinger, 5)
		end
	end
end)

function mpx()return stats.get_int("MPPLY_LAST_MP_CHAR")end 
CSYONS2:add_action("Dax", function()
	        stats.set_int("MP"..mpx().."_XM22JUGGALOWORKCDTIMER", -1)
end)

CSYONS2:add_action("Summon The Grinch", function()
    globals.set_int(2756261, 171)
    globals.set_int(2756259, 6)
end)

CSYON1 = Online:add_submenu("⫸ Unlocker Cars")
local CSYONS1 = CSYON1:add_submenu("Drug Wars 1.64 DLC Vehicles")

CSYONS1:add_action("Activate Drug Wars DLC Vehicles", function()
globals.set_int(262145+33957,1)--ENTITY3
globals.set_int(262145+33959,1)--JOURNEY2
globals.set_int(262145+33961,1)--annis 300r
globals.set_int(262145+33960,1)--SURFER3
globals.set_int(262145+33958,1)--TULIP2
globals.set_int(262145+33972,1)--boor
globals.set_int(262145+33962,1)--brickade2
globals.set_int(262145+33967,1)--broadway
globals.set_int(262145+33971,1)--eudora
globals.set_int(262145+33969,1)--everon2
globals.set_int(262145+33966,1)--issi8
globals.set_int(262145+33968,1)--panthere
globals.set_int(262145+33965,1)--powersurge
globals.set_int(262145+33964,1)--tahoma
globals.set_int(262145+33970,1)--virtue
globals.set_int(262145+33963,1)--taxi
end)

CSYONS3N = CSYONS2:add_submenu("Instructions for LSCM LVL")
CSYONS3N:add_action("Buy A Membership, Activate, Sit in", function() end)

CSYONS3N:add_action("A Test Car And Go To The Track", function() end)

CSYONS3N:add_action("", function() end)

CSYONS3N:add_action("Then Activate", function() end)

CSYONS3N:add_action("And Buy Something In The LSCM Store", function() end)

CSYONS3N:add_action("", function() end)

CSYONS3N:add_action("Then Change Session To Apply Lvl 1000", function() end)

CSYONS3N:add_action("If You've Used LS Tuner Awards Unlock", function() end)

CSYONS3N:add_action("Before, All Unlocks Will Be Temporary Only", function() end)

CSYONS3N:add_action("Only", function() end)

local function Text(text)
	mainMenu:add_action(text,  function() end)
end

Text("**************************************************************************")

Offlinex64 = mainMenu:add_submenu("                        **💬 Read Me 💬**                        ")
Text("**************************************************************************")
Text("*******************Hotkeys*********************************")
Text("【 Hotkey 】 Car boost Hotkey INSERT")
Text("【 Hotkey 】 Drop Ped Money Hotkey F3")
Text("【 Hotkey 】 Stop Car boost Hotkey Shift")


local function Text(text)
	Offlinex64:add_action(text,  function() end)
end

Offlinex6333t = Offlinex64:add_submenu("                        **🔽 Credits 🔼**                        ")


local function Text(text)
	Offlinex6333t:add_action(text,  function() end)
end

Text ("                        ** CSYON **                        ")
Text ("                        ** Thanks for Support my work**                        ")
Text ("                        ** Thanks to all for lua scripts sharing**                        ")
Text ("                        ** on Unknowncheats**                        ")

local function Text(text)
	Offlinex64:add_action(text,  function() end)
end

Text("**********************************************************")

Text("          🐨 UKC : CSYON")

Text("🐨 Warning : you are not allowed Copying and selling this script")

Text("**********************************************************")

local function Text(text)
	Offlinex64:add_action(text,  function() end)
end

Text("   🐨 Discord Server :")
Text("   🐨 https://discord.gg/JaCvtj6yQK")


Text("**********************************************************")

Text("   Download Vote in UKC A+  ")
Text("   thanks for Support  ")

Text("**********************************************************")