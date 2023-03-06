function table_get_keys(t, sorted)
    sorted = sorted or false
    local keys={}
    for key,_ in pairs(t) do
      table.insert(keys, key)
    end
    if sorted then
        return table.sort(keys)
    end
    return keys
end
function table_get_values(t, sorted)
    sorted = sorted or false
    local values={}
    for _,value in pairs(t) do
      table.insert(values, value)
    end
    if sorted then
        return table.sort(values)
    end
    return values
end
function table_index_of(array, value)
    for i, v in ipairs(array) do
        if v == value then
            return i
        end
    end
    return nil
end
function table_key_of(tbl, value)
    for k, v in pairs(tbl) do
        if v == value then
            return k
        end
    end
    return nil
end
function table_get_previous_element(array, value)
    local index = table_index_of(array, value)
    if index == nil then
        return nil
    end
    if index == 1 then
        return nil
    end
    return array[index - 1]
end
function table_dump(o)
    if type(o) == 'table' then
    local s = '{ '
    for k,v in pairs(o) do
        if type(k) ~= 'number' then k = '"'..k..'"' end
        s = s .. '['..k..'] = ' .. table_dump(v) .. ','
    end
    return s .. '} '
    else
    return tostring(o)
    end
end
function table_count(T)
    local count = 0
    for _ in pairs(T) do count = count + 1 end
    return count
end
function table_invert(t)
    local s={}
    for k,v in pairs(t) do
      s[v]=k
    end
    return s
end
function array_contains(arr, val)
    for i = 1, #arr do
        if arr[i] == val then return true end
    end 
    return false 
end
function table_clone(org)
    return {table.unpack(org)}
end
function table_shallowcopy(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in pairs(orig) do
            copy[orig_key] = orig_value
        end
    else -- number, string, boolean, etc
        copy = orig
    end
    return copy
end
function table_deepcopy(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in next, orig, nil do
            copy[deepcopy(orig_key)] = deepcopy(orig_value)
        end
        setmetatable(copy, deepcopy(getmetatable(orig)))
    else -- number, string, boolean, etc
        copy = orig
    end
    return copy
end
function __genOrderedIndex( t )
    local orderedIndex = {}
    for key in pairs(t) do
        table.insert( orderedIndex, key )
    end
    table.sort( orderedIndex )
    return orderedIndex
end

function orderedNext(t, state)
    -- Equivalent of the next function, but returns the keys in the alphabetic
    -- order. We use a temporary ordered key table that is stored in the
    -- table being iterated.

    local key = nil
    --print("orderedNext: state = "..tostring(state) )
    if state == nil then
        -- the first time, generate the index
        t.__orderedIndex = __genOrderedIndex( t )
        key = t.__orderedIndex[1]
    else
        -- fetch the next value
        for i = 1,#t.__orderedIndex do
            if t.__orderedIndex[i] == state then
                key = t.__orderedIndex[i+1]
            end
        end
    end

    if key then
        return key, t[key]
    end

    -- no more value to return, cleanup
    t.__orderedIndex = nil
    return
end

function table_sort(t)
    -- Equivalent of the pairs() function on tables. Allows to iterate
    -- in order
    return orderedNext, t, nil
end



Event = {
    OnPlayerChanged = "OnPlayerChanged", -- > function(Ped|nil oldPlayer, Ped|nil newPlayer)
    OnPlayerStateChanged = "OnPlayerStateChanged", -- > function(Integer oldState, Integer newState)
    OnVehicleChanged = "OnVehicleChanged", -- > function(Vehicle|nil oldVehicle, Vehicle|nil newVehicle)
    OnWeaponChanged = "OnWeaponChanged" -- > function(Weapon|nil oldWeapon, Weapon|nil newWeapon)
}
events = {
    "OnPlayerChanged", -- > function(Ped|nil oldPlayer, Ped|nil newPlayer)
    "OnPlayerStateChanged", -- > function(Integer oldState, Integer newState)
    "OnVehicleChanged", -- > function(Vehicle|nil oldVehicle, Vehicle|nil newVehicle)
    "OnWeaponChanged" -- > function(Weapon|nil oldWeapon, Weapon|nil newWeapon)
}


Global = {
    UniqueCargo = 1683827, -- bool
    Snow = 266869, -- bool
    SessionType = 1575012, -- int
    SessionTrigger = 1574589, -- bool
    IsReplay = 1575013, -- bool
    CreateVehicle = 2725269, -- hash
    ChangeModelTrigger = 2671449+59, -- bool 1.61
    ChangeModel = 2671449+46 -- hash
}
GlobalName = table_invert(Global)


KeyCode = {
    VK_LBUTTON = 1, -- Left mouse button
    VK_RBUTTON = 2, -- Right mouse button
    VK_CANCEL = 3, -- Control-break processing
    VK_MBUTTON = 4, -- Middle mouse button (three-button mouse)
    VK_XBUTTON1 = 5, -- Windows 2000: X1 mouse button
    VK_XBUTTON2 = 6, -- Windows 2000: X2 mouse button
    VK_BACK = 8, -- BACKSPACE key
    VK_TAB = 9, -- TAB key
    VK_CLEAR = 12, -- CLEAR key
    VK_RETURN = 13, -- ENTER key
    VK_SHIFT = 16, -- SHIFT key
    VK_CONTROL = 17, -- CTRL key
    VK_MENU = 18, -- ALT key
    VK_PAUSE = 19, -- PAUSE key
    VK_CAPITAL = 20, -- CAPS LOCK key
    VK_KANA = 21, -- IME Kana mode
    VK_HANGUEL = 21, -- IME Hanguel mode (maintained for compatibility; use VK_HANGUL)
    VK_HANGUL = 21, -- IME Hangul mode
    VK_JUNJA = 23, -- IME Junja mode
    VK_FINAL = 24, -- IME final mode
    VK_HANJA = 25, -- IME Hanja mode
    VK_KANJI = 25, -- IME Kanji mode
    VK_ESCAPE = 27, -- ESC key
    VK_CONVERT = 28, -- IME convert
    VK_NONCONVERT = 29, -- IME nonconvert
    VK_ACCEPT = 30, -- IME accept
    VK_MODECHANGE = 31, -- IME mode change request
    VK_SPACE = 32, -- SPACEBAR
    VK_PRIOR = 33, -- PAGE UP key
    VK_NEXT = 34, -- PAGE DOWN key
    VK_END = 35, -- END key
    VK_HOME = 36, -- HOME key
    VK_LEFT = 37, -- LEFT ARROW key
    VK_UP = 38, -- UP ARROW key
    VK_RIGHT = 39, -- RIGHT ARROW key
    VK_DOWN = 40, -- DOWN ARROW key
    VK_SELECT = 41, -- SELECT key
    VK_PRINT = 42, -- PRINT key
    VK_EXECUTE = 43, -- EXECUTE key
    VK_SNAPSHOT = 44, -- PRINT SCREEN key
    VK_INSERT = 45, -- INS key
    VK_DELETE = 46, -- DEL key
    VK_HELP = 47, -- HELP key
    VK_0 = 48,
    VK_1 = 49,
    VK_2 = 50,
    VK_3 = 51,
    VK_4 = 52,
    VK_5 = 53,
    VK_6 = 54,
    VK_7 = 55,
    VK_8 = 56,
    VK_9 = 57,
    A = 65,
    B = 66,
    C = 67,
    D = 68,
    E = 69,
    F = 70,
    G = 71,
    H = 72,
    I = 73,
    J = 74,
    K = 75,
    L = 76,
    M = 77,
    N = 78,
    O = 79,
    P = 80,
    Q = 81,
    R = 82,
    S = 83,
    T = 84,
    U = 85,
    V = 86,
    W = 87,
    X = 88,
    Y = 89,
    Z = 90,
    VK_LWIN = 91, -- Left Windows key (Microsoft® Natural® keyboard)
    VK_RWIN = 92, -- Right Windows key (Natural keyboard)
    VK_APPS = 93, -- Applications key (Natural keyboard)
    VK_SLEEP = 95, -- Computer Sleep key
    VK_NUMPAD0 = 96, -- Numeric keypad 0 key
    VK_NUMPAD1 = 97, -- Numeric keypad 1 key
    VK_NUMPAD2 = 98, -- Numeric keypad 2 key
    VK_NUMPAD3 = 99, -- Numeric keypad 3 key
    VK_NUMPAD4 = 100, -- Numeric keypad 4 key
    VK_NUMPAD5 = 101, -- Numeric keypad 5 key
    VK_NUMPAD6 = 102, -- Numeric keypad 6 key
    VK_NUMPAD7 = 103, -- Numeric keypad 7 key
    VK_NUMPAD8 = 104, -- Numeric keypad 8 key
    VK_NUMPAD9 = 105, -- Numeric keypad 9 key
    VK_MULTIPLY = 106, -- Multiply key
    VK_ADD = 107, -- Add key
    VK_SEPARATOR = 108, -- Separator key
    VK_SUBTRACT = 109, -- Subtract key
    VK_DECIMAL = 110, -- Decimal key
    VK_DIVIDE = 111, -- Divide key
    VK_F1 = 112, -- F1 key
    VK_F2 = 113, -- F2 key
    VK_F3 = 114, -- F3 key
    VK_F4 = 115, -- F4 key
    VK_F5 = 116, -- F5 key
    VK_F6 = 117, -- F6 key
    VK_F7 = 118, -- F7 key
    VK_F8 = 119, -- F8 key
    VK_F9 = 120, -- F9 key
    VK_F10 = 121, -- F10 key
    VK_F11 = 122, -- F11 key
    VK_F12 = 123, -- F12 key
    VK_F13 = 124, -- F13 key
    VK_F14 = 125, -- F14 key
    VK_F15 = 126, -- F15 key
    VK_F16 = 127, -- F16 key
    VK_F17 = 128, -- F17 key
    VK_F18 = 129, -- F18 key
    VK_F19 = 130, -- F19 key
    VK_F20 = 131, -- F20 key
    VK_F21 = 132, -- F21 key
    VK_F22 = 133, -- F22 key
    VK_F23 = 134, -- F23 key
    VK_F24 = 135, -- F24 key
    VK_NUMLOCK = 144, -- NUM LOCK key
    VK_SCROLL = 145, -- SCROLL LOCK key
    VK_LSHIFT = 160, -- Left SHIFT key
    VK_RSHIFT = 161, -- Right SHIFT key
    VK_LCONTROL = 162, -- Left CONTROL key
    VK_RCONTROL = 163, -- Right CONTROL key
    VK_LMENU = 164, -- Left MENU key
    VK_RMENU = 165, -- Right MENU key
    VK_BROWSER_BACK = 166, -- Windows 2000: Browser Back key
    VK_BROWSER_FORWARD = 167, -- Windows 2000: Browser Forward key
    VK_BROWSER_REFRESH = 168, -- Windows 2000: Browser Refresh key
    VK_BROWSER_STOP = 169, -- Windows 2000: Browser Stop key
    VK_BROWSER_SEARCH = 170, -- Windows 2000: Browser Search key
    VK_BROWSER_FAVORITES = 171, -- Windows 2000: Browser Favorites key
    VK_BROWSER_HOME = 172, -- Windows 2000: Browser Start and Home key
    VK_VOLUME_MUTE = 173, -- Windows 2000: Volume Mute key
    VK_VOLUME_DOWN = 174, -- Windows 2000: Volume Down key
    VK_VOLUME_UP = 175, -- Windows 2000: Volume Up key
    VK_MEDIA_NEXT_TRACK = 176, -- Windows 2000: Next Track key
    VK_MEDIA_PREV_TRACK = 177, -- Windows 2000: Previous Track key
    VK_MEDIA_STOP = 178, -- Windows 2000: Stop Media key
    VK_MEDIA_PLAY_PAUSE = 179, -- Windows 2000: Play/Pause Media key
    VK_LAUNCH_MAIL = 180, -- Windows 2000: Start Mail key
    VK_LAUNCH_MEDIA_SELECT = 181, -- Windows 2000: Select Media key
    VK_LAUNCH_APP1 = 182, -- Windows 2000: Start Application 1 key
    VK_LAUNCH_APP2 = 183, -- Windows 2000: Start Application 2 key
    VK_OEM_1 = 186, -- Windows 2000: For the US standard keyboard, the ';:' key
    VK_OEM_PLUS = 187, -- Windows 2000: For any country/region, the '+' key
    VK_OEM_COMMA = 188, -- Windows 2000: For any country/region, the ',' key
    VK_OEM_MINUS = 189, -- Windows 2000: For any country/region, the '-' key
    VK_OEM_PERIOD = 190, -- Windows 2000: For any country/region, the '.' key
    VK_OEM_2 = 191, -- Windows 2000: For the US standard keyboard, the '/?' key
    VK_OEM_3 = 192, -- Windows 2000: For the US standard keyboard, the '`~' key
    VK_OEM_4 = 219, -- Windows 2000: For the US standard keyboard, the '[{' key
    VK_OEM_5 = 220, -- Windows 2000: For the US standard keyboard, the '\|' key
    VK_OEM_6 = 221, -- Windows 2000: For the US standard keyboard, the ']}' key
    VK_OEM_7 = 222, -- Windows 2000: For the US standard keyboard, the 'single-quote/double-quote' key
    VK_OEM_8 = 223, -- 
    VK_OEM_102 = 226, -- Windows 2000: Either the angle bracket key or the backslash key on the RT 102-key keyboard
    VK_PROCESSKEY = 229, -- Windows 95/98, Windows NT 4.0, Windows 2000: IME PROCESS key
    VK_PACKET = 231, -- Windows 2000: Used to pass Unicode characters as if they were keystrokes. The VK_PACKET key is the low word of a 32-bit Virtual Key value used for non-keyboard input methods. For more information, see Remark in KEYBDINPUT, SendInput, WM_KEYDOWN, and WM_KEYUP
    VK_ATTN = 246, -- Attn key
    VK_CRSEL = 247, -- CrSel key
    VK_EXSEL = 248, -- ExSel key
    VK_EREOF = 249, -- Erase EOF key
    VK_PLAY = 250, -- Play key
    VK_ZOOM = 251, -- Zoom key
    VK_NONAME = 252, -- Reserved for future use
    VK_PA1 = 253, -- PA1 key
    VK_OEM_CLEAR = 254 -- Clear key
}
KeyCodeName = table_invert(KeyCode)



RockstarStaff = {
    "AlpacaBarista",
    "AMoreno14",
    "Anghard07",
    "applecloning",
    "aquabull",
    "Aur3lian",
    "BackBoyoDrill",
    "BailMail99",
    "BananaGod951",
    "Bangers_RSG",
    "BanSparklinWater",
    "Bash_RSG",
    "BeoMonstarh",
    "BinnyAndTheJets",
    "bipolarcarp",
    "BlessedChu",
    "BlobbyFett22",
    "BrucieJuiceyIV",
    "Bubblez_RSG",
    "CapnZebraZorse",
    "ChangryMonkey",
    "CheeesesteakPhil",
    "ChefRSG",
    "Chunk_RSG",
    "Coffee_Collie",
    "CrazyCatPilots",
    "CriticalRegret",
    "DannSw",
    "DarkStar7171",
    "DAWNBILLA",
    "DeadOnAir",
    "DigitalFox9",
    "Dumptruck42168",
    "ExoSnowBoarder",
    "ExtremeThanks15",
    "FecundWolf",
    "FishingFissures",
    "Flares4Lyfe",
    "FluteOfMilton",
    "flyingcobra16",
    "ForrestTrump69",
    "Fortune_Cukie",
    "FoxesAreCool69",
    "FruitPuncher15",
    "G_ashman",
    "Ghostofwar1",
    "godlyGoodestBoi",
    "GTAdev3",
    "GTAdev4",
    "HammerDaddy69",
    "HotTub_RSG",
    "Huginn5",
    "IM-_-Wassup",
    "jakw0lf",
    "johnet123",
    "JPEGMAFIA_RSG",
    "JulianApost4te",
    "Kakorot02",
    "kingmario11",
    "KingOfGolf",
    "Klang_RSG",
    "KorruptUserDayta",
    "KrunchyCh1cken",
    "KrustyShackles",
    "Laurie_Williams",
    "LazerGameBounce",
    "LazingLion",
    "Lean1_RSG",
    "LivelyCommanderS",
    "Logic_rsg",
    "Long-boi-load",
    "M1thras",
    "MaxPayne3Dev11",
    "MaxPayne3Dev12",
    "MaxPayne3Dev9",
    "MaxPayneDev1",
    "MaxPayneDev10",
    "MaxPayneDev11",
    "MaxPayneDev12",
    "MaxPayneDev13",
    "MaxPayneDev14",
    "MaxPayneDev15",
    "MaxPayneDev16",
    "MaxPayneDev2",
    "MaxPayneDev3",
    "MaxPayneDev4",
    "MaxPayneDev5",
    "MaxPayneDev6",
    "MaxPayneDev7",
    "MaxPayneDev8",
    "MaxPayneDev9",
    "MonkeyViking",
    "NoAuthorityHere",
    "NootN0ot",
    "NotSweetPlumbus",
    "OilyLordAinsley",
    "PassiveSalon",
    "Paulverines",
    "PayneInUrAbs",
    "PearBiscuits34",
    "pigeon_nominate",
    "PipPipJongles",
    "PisswasserMax",
    "Player7_RSG",
    "Player8_RSG",
    "PlayRockstar1",
    "PlayRockstar5",
    "playrockstar6",
    "Poppernopple",
    "ramendingo",
    "random_123",
    "random123",
    "RapidRaichu",
    "RDR_Dev",
    "Rockin5",
    "RollD20",
    "Rossthetic",
    "RSGGuest12",
    "RSGGuest40",
    "RSGGuest50",
    "RSGGuest7",
    "RSGGuestV",
    "RSGINTJoe",
    "RSGWolfman",
    "ScentedPotter",
    "ScentedString",
    "ScottM_RSG",
    "SecretWizzle54",
    "SheddingYeti",
    "shibuz_gamer123",
    "SlightlyEvilHoss",
    "SlowMoKing",
    "Smooth_Landing",
    "Sonknuck-",
    "Spacer-galore",
    "st1nky_p1nky",
    "StompoGrande",
    "StrongBelwas1",
    "SuperTrevor123",
    "Surgeio",
    "SweetPlumbus",
    "Tamehippo",
    "Th3_Morr1gan",
    "The_Real_Harambe",
    "TheUntamedVoid",
    "thewho146",
    "Thrillhouse12",
    "Titan261",
    "Ton_RSG",
    "TonyMSD1",
    "trajan5",
    "TylerTGTAB",
    "uwu-bend",
    "VickDMF",
    "VinnyPetrol",
    "vulconn",
    "Wanted_Sign42",
    "Wawaweewa_I_Like",
    "whiskylifter",
    "WickedFalcon4054",
    "Wilted_spinach",
    "WindmillDuncan",
    "x_Shannandoo_x",
    "xCuteBunny",
    "YellingRat",
    "YUyu-lampon",
    "Z3ro_Chill",
    "ZombieTom66"
}












PedType = {
    Any = -1,
    Player = 1,
    Male = 4 ,
    Female = 5 ,
    Cop = 6,
    Human = 26,
    SWAT = 27,
    Animal = 28,
    Army = 29
}
PedTypeName = table_invert(PedType)

PedConfigFlag = {
    CanPunch = 18,
    CanFlyThruWindscreen = 32,
    DiesByRagdoll = 33,
    PutOnMotorcycleHelmet = 35,
    NoCollision = 52,
    IsShooting = 58,
    IsOnGround = 60,
    NoCollide = 62,
    Dead = 71,
    IsSniperScopeActive = 72,
    SuperDead = 73,
    IsInAir = 76,
    IsAiming = 78,
    Drunk = 100,
    IsNotRagdollAndNotPlayingAnim = 104,
    NoPlayerMelee = 122,
    NmMessage466 = 125,
    CanAttackFriendlies = 140,
    InjuredLimp = 166,
    InjuredLimp2 = 170,
    DisableShufflingToDriverSeat = 184,
    InjuredDown = 187,
    Shrink = 223,
    MeleeCombat = 224,
    DisableStoppingVehEngine = 241,
    IsOnStairs = 253,
    HasOneLegOnGround = 276,
    NoWrithe = 281,
    Freeze = 292,
    IsStill = 301,
    NoPedMelee = 314,
    PedSwitchingWeapon = 331,
    Alpha = 410,
    DisablePropKnockOff = 423,
    DisableStartingVehEngine = 429,
    FlamingFootprints = 421
}
PedConfigFlagName = table_invert(PedConfigFlag)

-- Update 04/03/2020, Ped count [739]
PedHex = {
   a_c_boar = 0xCE5FF074,
   a_c_cat_01 = 0x573201B8,
   a_c_chickenhawk = 0xAAB71F62,
   a_c_chimp = 0xA8683715,
   a_c_chop = 0x14EC17EA,
   a_c_cormorant = 0x56E29962,
   a_c_cow = 0xFCFA9E1E,
   a_c_coyote = 0x644AC75E,
   a_c_crow = 0x18012A9F,
   a_c_deer = 0xD86B5A95,
   a_c_dolphin = 0x8BBAB455,
   a_c_fish = 0x2FD800B7,
   a_c_hen = 0x6AF51FAF,
   a_c_humpback = 0x471BE4B2,
   a_c_husky = 0x4E8F95A2,
   a_c_killerwhale = 0x8D8AC8B9,
   a_c_mtlion = 0x1250D7BA,
   a_c_pig = 0xB11BAB56,
   a_c_pigeon = 0x06A20728,
   a_c_poodle = 0x431D501C,
   a_c_pug = 0x6D362854,
   a_c_rabbit_01 = 0xDFB55C81,
   a_c_rat = 0xC3B52966,
   a_c_retriever = 0x349F33E1,
   a_c_rhesus = 0xC2D06F53,
   a_c_rottweiler = 0x9563221D,
   a_c_seagull = 0xD3939DFD,
   a_c_sharkhammer = 0x3C831724,
   a_c_sharktiger = 0x06C3F072,
   a_c_shepherd = 0x431FC24C,
   a_c_stingray = 0xA148614D,
   a_c_westy = 0xAD7844BB,
   a_f_m_beach_01 = 0x303638A7,
   a_f_m_bevhills_01 = 0xBE086EFD,
   a_f_m_bevhills_02 = 0xA039335F,
   a_f_m_bodybuild_01 = 0x3BD99114,
   a_f_m_business_02 = 0x1FC37DBC,
   a_f_m_downtown_01 = 0x654AD86E,
   a_f_m_eastsa_01 = 0x9D3DCB7A,
   a_f_m_eastsa_02 = 0x63C8D891,
   a_f_m_fatbla_01 = 0xFAB48BCB,
   a_f_m_fatcult_01 = 0xB5CF80E4,
   a_f_m_fatwhite_01 = 0x38BAD33B,
   a_f_m_ktown_01 = 0x52C824DE,
   a_f_m_ktown_02 = 0x41018151,
   a_f_m_prolhost_01 = 0x169BD1E1,
   a_f_m_salton_01 = 0xDE0E0969,
   a_f_m_skidrow_01 = 0xB097523B,
   a_f_m_soucent_01 = 0x745855A1,
   a_f_m_soucent_02 = 0xF322D338,
   a_f_m_soucentmc_01 = 0xCDE955D2,
   a_f_m_tourist_01 = 0x505603B9,
   a_f_m_tramp_01 = 0x48F96F5B,
   a_f_m_trampbeac_01 = 0x8CA0C266,
   a_f_o_genstreet_01 = 0x61C81C85,
   a_f_o_indian_01 = 0xBAD7BB80,
   a_f_o_ktown_01 = 0x47CF5E96,
   a_f_o_salton_01 = 0xCCFF7D8A,
   a_f_o_soucent_01 = 0x3DFA1830,
   a_f_o_soucent_02 = 0xA56DE716,
   a_f_y_beach_01 = 0xC79F6928,
   a_f_y_bevhills_01 = 0x445AC854,
   a_f_y_bevhills_02 = 0x5C2CF7F8,
   a_f_y_bevhills_03 = 0x20C8012F,
   a_f_y_bevhills_04 = 0x36DF2D5D,
   a_f_y_business_01 = 0x2799EFD8,
   a_f_y_business_02 = 0x31430342,
   a_f_y_business_03 = 0xAE86FDB4,
   a_f_y_business_04 = 0xB7C61032,
   a_f_y_eastsa_01 = 0xF5B0079D,
   a_f_y_eastsa_02 = 0x0438A4AE,
   a_f_y_eastsa_03 = 0x51C03FA4,
   a_f_y_epsilon_01 = 0x689C2A80,
   a_f_y_femaleagent = 0x50610C43,
   a_f_y_fitness_01 = 0x457C64FB,
   a_f_y_fitness_02 = 0x13C4818C,
   a_f_y_genhot_01 = 0x2F4AEC3E,
   a_f_y_golfer_01 = 0x7DD8FB58,
   a_f_y_hiker_01 = 0x30830813,
   a_f_y_hippie_01 = 0x1475B827,
   a_f_y_hipster_01 = 0x8247D331,
   a_f_y_hipster_02 = 0x97F5FE8D,
   a_f_y_hipster_03 = 0xA5BA9A16,
   a_f_y_hipster_04 = 0x199881DC,
   a_f_y_indian_01 = 0x092D9CC1,
   a_f_y_juggalo_01 = 0xDB134533,
   a_f_y_runner_01 = 0xC7496729,
   a_f_y_rurmeth_01 = 0x3F789426,
   a_f_y_scdressy_01 = 0xDB5EC400,
   a_f_y_skater_01 = 0x695FE666,
   a_f_y_soucent_01 = 0x2C641D7A,
   a_f_y_soucent_02 = 0x5A8EF9CF,
   a_f_y_soucent_03 = 0x87B25415,
   a_f_y_tennis_01 = 0x550C79C6,
   a_f_y_topless_01 = 0x9CF26183,
   a_f_y_tourist_01 = 0x563B8570,
   a_f_y_tourist_02 = 0x9123FB40,
   a_f_y_vinewood_01 = 0x19F41F65,
   a_f_y_vinewood_02 = 0xDAB6A0EB,
   a_f_y_vinewood_03 = 0x379DDAB8,
   a_f_y_vinewood_04 = 0xFAE46146,
   a_f_y_yoga_01 = 0xC41B062E,
   a_m_m_acult_01 = 0x5442C66B,
   a_m_m_afriamer_01 = 0xD172497E,
   a_m_m_beach_01 = 0x403DB4FD,
   a_m_m_beach_02 = 0x787FA588,
   a_m_m_bevhills_01 = 0x54DBEE1F,
   a_m_m_bevhills_02 = 0x3FB5C3D3,
   a_m_m_business_01 = 0x7E6A64B7,
   a_m_m_eastsa_01 = 0xF9A6F53F,
   a_m_m_eastsa_02 = 0x07DD91AC,
   a_m_m_farmer_01 = 0x94562DD7,
   a_m_m_fatlatin_01 = 0x61D201B3,
   a_m_m_genfat_01 = 0x06DD569F,
   a_m_m_genfat_02 = 0x13AEF042,
   a_m_m_golfer_01 = 0xA9EB0E42,
   a_m_m_hasjew_01 = 0x6BD9B68C,
   a_m_m_hillbilly_01 = 0x6C9B2849,
   a_m_m_hillbilly_02 = 0x7B0E452F,
   a_m_m_indian_01 = 0xDDCAAA2C,
   a_m_m_ktown_01 = 0xD15D7E71,
   a_m_m_malibu_01 = 0x2FDE6EB7,
   a_m_m_mexcntry_01 = 0xDD817EAD,
   a_m_m_mexlabor_01 = 0xB25D16B2,
   a_m_m_og_boss_01 = 0x681BD012,
   a_m_m_paparazzi_01 = 0xECCA8C15,
   a_m_m_polynesian_01 = 0xA9D9B69E,
   a_m_m_prolhost_01 = 0x9712C38F,
   a_m_m_rurmeth_01 = 0x3BAD4184,
   a_m_m_salton_01 = 0x4F2E038A,
   a_m_m_salton_02 = 0x60F4A717,
   a_m_m_salton_03 = 0xB28C4A45,
   a_m_m_salton_04 = 0x964511B7,
   a_m_m_skater_01 = 0xD9D7588C,
   a_m_m_skidrow_01 = 0x01EEA6BD,
   a_m_m_socenlat_01 = 0x0B8D69E3,
   a_m_m_soucent_01 = 0x6857C9B7,
   a_m_m_soucent_02 = 0x9F6D37E1,
   a_m_m_soucent_03 = 0x8BD990BA,
   a_m_m_soucent_04 = 0xC2FBFEFE,
   a_m_m_stlat_02 = 0xC2A87702,
   a_m_m_tennis_01 = 0x546A5344,
   a_m_m_tourist_01 = 0xC89F0184,
   a_m_m_tramp_01 = 0x1EC93FD0,
   a_m_m_trampbeac_01 = 0x53B57EB0,
   a_m_m_tranvest_01 = 0xE0E69974,
   a_m_m_tranvest_02 = 0xF70EC5C4,
   a_m_o_acult_01 = 0x55446010,
   a_m_o_acult_02 = 0x4BA14CCA,
   a_m_o_beach_01 = 0x8427D398,
   a_m_o_genstreet_01 = 0xAD54E7A8,
   a_m_o_ktown_01 = 0x1536D95A,
   a_m_o_salton_01 = 0x20208E4D,
   a_m_o_soucent_01 = 0x2AD8921B,
   a_m_o_soucent_02 = 0x4086BD77,
   a_m_o_soucent_03 = 0x0E32D8D0,
   a_m_o_tramp_01 = 0x174D4245,
   a_m_y_acult_01 = 0xB564882B,
   a_m_y_acult_02 = 0x80E59F2E,
   a_m_y_beach_01 = 0xD1FEB884,
   a_m_y_beach_02 = 0x23C7DC11,
   a_m_y_beach_03 = 0xE7A963D9,
   a_m_y_beachvesp_01 = 0x7E0961B8,
   a_m_y_beachvesp_02 = 0xCA56FA52,
   a_m_y_bevhills_01 = 0x76284640,
   a_m_y_bevhills_02 = 0x668BA707,
   a_m_y_breakdance_01 = 0x379F9596,
   a_m_y_busicas_01 = 0x9AD32FE9,
   a_m_y_business_01 = 0xC99F21C4,
   a_m_y_business_02 = 0xB3B3F5E6,
   a_m_y_business_03 = 0xA1435105,
   a_m_y_cyclist_01 = 0xFDC653C7,
   a_m_y_dhill_01 = 0xFF3E88AB,
   a_m_y_downtown_01 = 0x2DADF4AA,
   a_m_y_eastsa_01 = 0xA4471173,
   a_m_y_eastsa_02 = 0x168775F6,
   a_m_y_epsilon_01 = 0x77D41A3E,
   a_m_y_epsilon_02 = 0xAA82FF9B,
   a_m_y_gay_01 = 0xD1CCE036,
   a_m_y_gay_02 = 0xA5720781,
   a_m_y_genstreet_01 = 0x9877EF71,
   a_m_y_genstreet_02 = 0x3521A8D2,
   a_m_y_golfer_01 = 0xD71FE131,
   a_m_y_hasjew_01 = 0xE16D8F01,
   a_m_y_hiker_01 = 0x50F73C0C,
   a_m_y_hippy_01 = 0x7D03E617,
   a_m_y_hipster_01 = 0x2307A353,
   a_m_y_hipster_02 = 0x14D506EE,
   a_m_y_hipster_03 = 0x4E4179C6,
   a_m_y_indian_01 = 0x2A22FBCE,
   a_m_y_jetski_01 = 0x2DB7EEF3,
   a_m_y_juggalo_01 = 0x91CA3E2C,
   a_m_y_ktown_01 = 0x1AF6542C,
   a_m_y_ktown_02 = 0x297FF13F,
   a_m_y_latino_01 = 0x132C1A8E,
   a_m_y_methhead_01 = 0x696BE0A9,
   a_m_y_mexthug_01 = 0x3053E555,
   a_m_y_motox_01 = 0x64FDEA7D,
   a_m_y_motox_02 = 0x77AC8FDA,
   a_m_y_musclbeac_01 = 0x4B652906,
   a_m_y_musclbeac_02 = 0xC923247C,
   a_m_y_polynesian_01 = 0x8384FC9F,
   a_m_y_roadcyc_01 = 0xF561A4C6,
   a_m_y_runner_01 = 0x25305EEE,
   a_m_y_runner_02 = 0x843D9D0F,
   a_m_y_salton_01 = 0xD7606C30,
   a_m_y_skater_01 = 0xC1C46677,
   a_m_y_skater_02 = 0xAFFAC2E4,
   a_m_y_soucent_01 = 0xE716BDCB,
   a_m_y_soucent_02 = 0xACA3C8CA,
   a_m_y_soucent_03 = 0xC3F0F764,
   a_m_y_soucent_04 = 0x8A3703F1,
   a_m_y_stbla_01 = 0xCF92ADE9,
   a_m_y_stbla_02 = 0x98C7404F,
   a_m_y_stlat_01 = 0x8674D5FC,
   a_m_y_stwhi_01 = 0x2418C430,
   a_m_y_stwhi_02 = 0x36C6E98C,
   a_m_y_sunbathe_01 = 0xB7292F0C,
   a_m_y_surfer_01 = 0xEAC2C7EE,
   a_m_y_vindouche_01 = 0xC19377E7,
   a_m_y_vinewood_01 = 0x4B64199D,
   a_m_y_vinewood_02 = 0x5D15BD00,
   a_m_y_vinewood_03 = 0x1FDF4294,
   a_m_y_vinewood_04 = 0x31C9E669,
   a_m_y_yoga_01 = 0xAB0A7155,
   cs_amandatownley = 0x95EF18E3,
   cs_andreas = 0xE7565327,
   cs_ashley = 0x26C3D079,
   cs_bankman = 0x9760192E,
   cs_barry = 0x69591CF7,
   cs_beverly = 0xB46EC356,
   cs_brad = 0xEFE5AFE6,
   cs_bradcadaver = 0x7228AF60,
   cs_carbuyer = 0x8CCE790F,
   cs_casey = 0xEA969C40,
   cs_chengsr = 0x30DB9D7B,
   cs_chrisformage = 0xC1F380E6,
   cs_clay = 0xDBCB9834,
   cs_dale = 0x0CE81655,
   cs_davenorton = 0x8587248C,
   cs_debra = 0xECD04FE9,
   cs_denise = 0x6F802738,
   cs_devin = 0x2F016D02,
   cs_dom = 0x4772AF42,
   cs_dreyfuss = 0x3C60A153,
   cs_drfriedlander = 0xA3A35C2F,
   cs_fabien = 0x47035EC1,
   cs_fbisuit_01 = 0x585C0B52,
   cs_floyd = 0x062547E7,
   cs_guadalope = 0x0F9513F1,
   cs_gurk = 0xC314F727,
   cs_hunter = 0x5B44892C,
   cs_janet = 0x3034F9E2,
   cs_jewelass = 0x4440A804,
   cs_jimmyboston = 0x039677BD,
   cs_jimmydisanto = 0xB8CC92B4,
   cs_joeminuteman = 0xF09D5E29,
   cs_johnnyklebitz = 0xFA8AB881,
   cs_josef = 0x459762CA,
   cs_josh = 0x450EEF9D,
   cs_karen_daniels = 0x4BAF381C,
   cs_lamardavis = 0x45463A0D,
   cs_lazlow = 0x38951A1B,
   cs_lestercrest = 0xB594F5C3,
   cs_lifeinvad_01 = 0x72551375,
   cs_magenta = 0x5816C61A,
   cs_manuel = 0xFBB374CA,
   cs_marnie = 0x574DE134,
   cs_martinmadrazo = 0x43595670,
   cs_maryann = 0x0998C7AD,
   cs_michelle = 0x70AEB9C8,
   cs_milton = 0xB76A330F,
   cs_molly = 0x45918E44,
   cs_movpremf_01 = 0x4BBA84D9,
   cs_movpremmale = 0x8D67EE7D,
   cs_mrk = 0xC3CC9A75,
   cs_mrs_thornhill = 0x4F921E6E,
   cs_mrsphillips = 0xCBFDA3CF,
   cs_natalia = 0x4EFEB1F0,
   cs_nervousron = 0x7896DA94,
   cs_nigel = 0xE1479C0B,
   cs_old_man1a = 0x1EEC7BDC,
   cs_old_man2 = 0x98F9E770,
   cs_omega = 0x8B70B405,
   cs_orleans = 0xAD340F5A,
   cs_paper = 0x6B38B8F8,
   cs_patricia = 0xDF8B1301,
   cs_priest = 0x4D6DE57E,
   cs_prolsec_02 = 0x1E9314A2,
   cs_russiandrunk = 0x46521A32,
   cs_siemonyetarian = 0xC0937202,
   cs_solomon = 0xF6D1E04E,
   cs_stevehains = 0xA4E0A1FE,
   cs_stretch = 0x893D6805,
   cs_tanisha = 0x42FE5370,
   cs_taocheng = 0x8864083D,
   cs_taostranslator = 0x53536529,
   cs_tenniscoach = 0x5C26040A,
   cs_terry = 0x3A5201C5,
   cs_tom = 0x69E8ABC3,
   cs_tomepsilon = 0x8C0FD4E2,
   cs_tracydisanto = 0x0609B130,
   cs_wade = 0xD266D9D6,
   cs_zimbor = 0xEAACAAF0,
   csb_abigail = 0x89768941,
   csb_agent = 0xD770C9B4,
   csb_anita = 0x0703F106,
   csb_anton = 0xA5C787B6,
   csb_ballasog = 0xABEF0004,
   csb_bride = 0x82BF7EA1,
   csb_burgerdrug = 0x8CDCC057,
   csb_car3guy1 = 0x04430687,
   csb_car3guy2 = 0x1383A508,
   csb_chef = 0xA347CA8A,
   csb_chef2 = 0xAE5BE23A,
   csb_chin_goon = 0xA8C22996,
   csb_cletus = 0xCAE9E5D5,
   csb_cop = 0x9AB35F63,
   csb_customer = 0xA44F6F8B,
   csb_denise_friend = 0xB58D2529,
   csb_fos_rep = 0x1BCC157B,
   csb_g = 0xA28E71D7,
   csb_groom = 0x7AAB19D2,
   csb_grove_str_dlr = 0xE8594E22,
   csb_hao = 0xEC9E8F1C,
   csb_hugh = 0x6F139B54,
   csb_imran = 0xE3420BDB,
   csb_jackhowitzer = 0x44BC7BB1,
   csb_janitor = 0xC2005A40,
   csb_maude = 0xBCC475CB,
   csb_money = 0x989DFD9A,
   csb_mp_agent14 = 0x6DBBFC8B,
   csb_mweather = 0x613E626C,
   csb_ortega = 0xC0DB04CF,
   csb_oscar = 0xF41F399B,
   csb_paige = 0x5B1FA0C3,
   csb_popov = 0x617D89E2,
   csb_porndudes = 0x2F4AFE35,
   csb_prologuedriver = 0xF00B49DB,
   csb_prolsec = 0x7FA2F024,
   csb_ramp_gang = 0xC2800DBE,
   csb_ramp_hic = 0x858C94B8,
   csb_ramp_hipster = 0x21F58BB4,
   csb_ramp_marine = 0x616C97B9,
   csb_ramp_mex = 0xF64ED7D0,
   csb_rashcosvki = 0x188099A9,
   csb_reporter = 0x2E420A24,
   csb_roccopelosi = 0xAA64168C,
   csb_screen_writer = 0x8BE12CEC,
   csb_stripper_01 = 0xAEEA76B5,
   csb_stripper_02 = 0x81441B71,
   csb_tonya = 0x6343DD19,
   csb_trafficwarden = 0xDE2937F3,
   csb_undercover = 0xEF785A6A,
   csb_vagspeak = 0x48FF4CA9,
   g_f_importexport_01 = 0x84A1B11A,
   g_f_y_ballas_01 = 0x158C439C,
   g_f_y_families_01 = 0x4E0CE5D3,
   g_f_y_lost_01 = 0xFD5537DE,
   g_f_y_vagos_01 = 0x5AA42C21,
   g_m_importexport_01 = 0xBCA2CCEA,
   g_m_m_armboss_01 = 0xF1E823A2,
   g_m_m_armgoon_01 = 0xFDA94268,
   g_m_m_armlieut_01 = 0xE7714013,
   g_m_m_chemwork_01 = 0xF6157D8F,
   g_m_m_chiboss_01 = 0xB9DD0300,
   g_m_m_chicold_01 = 0x106D9A99,
   g_m_m_chigoon_01 = 0x7E4F763F,
   g_m_m_chigoon_02 = 0xFF71F826,
   g_m_m_korboss_01 = 0x352A026F,
   g_m_m_mexboss_01 = 0x5761F4AD,
   g_m_m_mexboss_02 = 0x4914D813,
   g_m_y_armgoon_02 = 0xC54E878A,
   g_m_y_azteca_01 = 0x68709618,
   g_m_y_ballaeast_01 = 0xF42EE883,
   g_m_y_ballaorig_01 = 0x231AF63F,
   g_m_y_ballasout_01 = 0x23B88069,
   g_m_y_famca_01 = 0xE83B93B7,
   g_m_y_famdnf_01 = 0xDB729238,
   g_m_y_famfor_01 = 0x84302B09,
   g_m_y_korean_01 = 0x247502A9,
   g_m_y_korean_02 = 0x8FEDD989,
   g_m_y_korlieut_01 = 0x7CCBE17A,
   g_m_y_lost_01 = 0x4F46D607,
   g_m_y_lost_02 = 0x3D843282,
   g_m_y_lost_03 = 0x32B11CDC,
   g_m_y_mexgang_01 = 0xBDDD5546,
   g_m_y_mexgoon_01 = 0x26EF3426,
   g_m_y_mexgoon_02 = 0x31A3498E,
   g_m_y_mexgoon_03 = 0x964D12DC,
   g_m_y_pologoon_01 = 0x4F3FBA06,
   g_m_y_pologoon_02 = 0xA2E86156,
   g_m_y_salvaboss_01 = 0x905CE0CA,
   g_m_y_salvagoon_01 = 0x278C8CB7,
   g_m_y_salvagoon_02 = 0x3273A285,
   g_m_y_salvagoon_03 = 0x03B8C510,
   g_m_y_strpunk_01 = 0xFD1C49BB,
   g_m_y_strpunk_02 = 0x0DA1EAC6,
   hc_driver = 0x3B474ADF,
   hc_gunman = 0x0B881AEE,
   hc_hacker = 0x99BB00F8,
   ig_abigail = 0x400AEC41,
   ig_agent = 0x246AF208,
   ig_amandatownley = 0x6D1E15F7,
   ig_andreas = 0x47E4EEA0,
   ig_ashley = 0x7EF440DB,
   ig_avon = 0xFCE270C2,
   ig_ballasog = 0xA70B4A92,
   ig_bankman = 0x909D9E7F,
   ig_barry = 0x2F8845A3,
   ig_benny = 0xC4B715D2,
   ig_bestmen = 0x5746CD96,
   ig_beverly = 0xBDA21E5C,
   ig_brad = 0xBDBB4922,
   ig_bride = 0x6162EC47,
   ig_car3guy1 = 0x84F9E937,
   ig_car3guy2 = 0x75C34ACA,
   ig_casey = 0xE0FA2554,
   ig_chef = 0x49EADBF6,
   ig_chef2 = 0x85889AC3,
   ig_chengsr = 0xAAE4EA7B,
   ig_chrisformage = 0x286E54A7,
   ig_clay = 0x6CCFE08A,
   ig_claypain = 0x9D0087A8,
   ig_cletus = 0xE6631195,
   ig_dale = 0x467415E9,
   ig_davenorton = 0x15CD4C33,
   ig_denise = 0x820B33BD,
   ig_devin = 0x7461A0B0,
   ig_dom = 0x9C2DB088,
   ig_dreyfuss = 0xDA890932,
   ig_drfriedlander = 0xCBFC0DF5,
   ig_fabien = 0xD090C350,
   ig_fbisuit_01 = 0x3AE4A33B,
   ig_floyd = 0xB1B196B2,
   ig_g = 0x841BA933,
   ig_groom = 0xFECE8B85,
   ig_hao = 0x65978363,
   ig_hunter = 0xCE1324DE,
   ig_janet = 0x0D6D9C49,
   ig_jay_norris = 0x7A32EE74,
   ig_jewelass = 0x0F5D26BB,
   ig_jimmyboston = 0xEDA0082D,
   ig_jimmydisanto = 0x570462B9,
   ig_joeminuteman = 0xBE204C9B,
   ig_johnnyklebitz = 0x87CA80AE,
   ig_josef = 0xE11A9FB4,
   ig_josh = 0x799E9EEE,
   ig_karen_daniels = 0xEB51D959,
   ig_kerrymcintosh = 0x5B3BD90D,
   ig_lamardavis = 0x65B93076,
   ig_lazlow = 0xDFE443E5,
   ig_lestercrest_2 = 0x6E42FD26,
   ig_lestercrest = 0x4DA6E849,
   ig_lifeinvad_01 = 0x5389A93C,
   ig_lifeinvad_02 = 0x27BD51D4,
   ig_magenta = 0xFCDC910A,
   ig_malc = 0xF1BCA919,
   ig_manuel = 0xFD418E10,
   ig_marnie = 0x188232D0,
   ig_maryann = 0xA36F9806,
   ig_maude = 0x3BE8287E,
   ig_michelle = 0xBF9672F4,
   ig_milton = 0xCB3059B2,
   ig_molly = 0xAF03DDE1,
   ig_money = 0x37FACDA6,
   ig_mp_agent14 = 0xFBF98469,
   ig_mrk = 0xEDDCAB6D,
   ig_mrs_thornhill = 0x1E04A96B,
   ig_mrsphillips = 0x3862EEA8,
   ig_natalia = 0xDE17DD3B,
   ig_nervousron = 0xBD006AF1,
   ig_nigel = 0xC8B7167D,
   ig_old_man1a = 0x719D27F4,
   ig_old_man2 = 0xEF154C47,
   ig_omega = 0x60E6A7D8,
   ig_oneil = 0x2DC6D3E7,
   ig_orleans = 0x61D4C771,
   ig_ortega = 0x26A562B7,
   ig_paige = 0x154FCF3F,
   ig_paper = 0x999B00C6,
   ig_patricia = 0xC56E118C,
   ig_popov = 0x267630FE,
   ig_priest = 0x6437E77D,
   ig_prolsec_02 = 0x27B3AD75,
   ig_ramp_gang = 0xE52E126C,
   ig_ramp_hic = 0x45753032,
   ig_ramp_hipster = 0xDEEF9F6E,
   ig_ramp_mex = 0xE6AC74A4,
   ig_rashcosvki = 0x380C4DE6,
   ig_roccopelosi = 0xD5BA52FF,
   ig_russiandrunk = 0x3D0A5EB1,
   ig_screen_writer = 0xFFE63677,
   ig_siemonyetarian = 0x4C7B2F05,
   ig_solomon = 0x86BDFE26,
   ig_stevehains = 0x382121C8,
   ig_stretch = 0x36984358,
   ig_talina = 0xE793C8E8,
   ig_tanisha = 0x0D810489,
   ig_taocheng = 0xDC5C5EA5,
   ig_taostranslator = 0x7C851464,
   ig_tenniscoach = 0xA23B5F57,
   ig_terry = 0x67000B94,
   ig_tomepsilon = 0xCD777AAA,
   ig_tonya = 0xCAC85344,
   ig_tracydisanto = 0xDE352A35,
   ig_trafficwarden = 0x5719786D,
   ig_tylerdix = 0x5265F707,
   ig_vagspeak = 0xF9FD068C,
   ig_wade = 0x92991B72,
   ig_zimbor = 0x0B34D6F5,
   mp_f_boatstaff_01 = 0x3293B9CE,
   mp_f_cardesign_01 = 0x242C34A7,
   mp_f_chbar_01 = 0xC3F6E385,
   mp_f_cocaine_01 = 0x4B657AF8,
   mp_f_counterfeit_01 = 0xB788F1F5,
   mp_f_deadhooker = 0x73DEA88B,
   mp_f_execpa_01 = 0x432CA064,
   mp_f_execpa_02 = 0x5972CCF0,
   mp_f_forgery_01 = 0x781A3CF8,
   mp_f_freemode_01 = 0x9C9EFFD8,
   mp_f_helistaff_01 = 0x19B6FF06,
   mp_f_meth_01 = 0xD2B27EC1,
   mp_f_misty_01 = 0xD128FF9D,
   mp_f_stripperlite = 0x2970A494,
   mp_f_weed_01 = 0xB26573A3,
   mp_g_m_pros_01 = 0x6C9DD7C9,
   mp_m_avongoon = 0x9C13CB95,
   mp_m_boatstaff_01 = 0xC85F0A88,
   mp_m_bogdangoon = 0x4D5696F7,
   mp_m_claude_01 = 0xC0F371B7,
   mp_m_cocaine_01 = 0x56D38F95,
   mp_m_counterfeit_01 = 0x9855C974,
   mp_m_exarmy_01 = 0x45348DBB,
   mp_m_execpa_01 = 0x3E8417BC,
   mp_m_famdd_01 = 0x33A464E5,
   mp_m_fibsec_01 = 0x5CDEF405,
   mp_m_forgery_01 = 0x613E709B,
   mp_m_freemode_01 = 0x705E61F2,
   mp_m_g_vagfun_01 = 0xC4A617BD,
   mp_m_marston_01 = 0x38430167,
   mp_m_meth_01 = 0xEDB42F3F,
   mp_m_niko_01 = 0xEEDACFC9,
   mp_m_securoguard_01 = 0xDA2C984E,
   mp_m_shopkeep_01 = 0x18CE57D0,
   mp_m_waremech_01 = 0xF7A74139,
   mp_m_weapexp_01 = 0x36EA5B09,
   mp_m_weapwork_01 = 0x4186506E,
   mp_m_weed_01 = 0x917ED459,
   mp_s_m_armoured_01 = 0xCDEF5408,
   player_one = 0x9B22DBAF,
   player_two = 0x9B810FA2,
   player_zero = 0x0D7114C9,
   s_f_m_fembarber = 0x163B875B,
   s_f_m_maid_01 = 0xE093C5C6,
   s_f_m_shop_high = 0xAE47E4B0,
   s_f_m_sweatshop_01 = 0x312B5BC0,
   s_f_y_airhostess_01 = 0x5D71A46F,
   s_f_y_bartender_01 = 0x780C01BD,
   s_f_y_baywatch_01 = 0x4A8E5536,
   s_f_y_cop_01 = 0x15F8700D,
   s_f_y_factory_01 = 0x69F46BF3,
   s_f_y_hooker_01 = 0x028ABF95,
   s_f_y_hooker_02 = 0x14C3E407,
   s_f_y_hooker_03 = 0x031640AC,
   s_f_y_migrant_01 = 0xD55B2BF5,
   s_f_y_movprem_01 = 0x2300C816,
   s_f_y_ranger_01 = 0x9FC7F637,
   s_f_y_scrubs_01 = 0xAB594AB6,
   s_f_y_sheriff_01 = 0x4161D042,
   s_f_y_shop_low = 0xA96E2604,
   s_f_y_shop_mid = 0x3EECBA5D,
   s_f_y_stripper_01 = 0x52580019,
   s_f_y_stripper_02 = 0x6E0FB794,
   s_f_y_stripperlite = 0x5C14EDFA,
   s_f_y_sweatshop_01 = 0x8502B6B2,
   s_m_m_ammucountry = 0x0DE9A30A,
   s_m_m_armoured_01 = 0x95C76ECD,
   s_m_m_armoured_02 = 0x63858A4A,
   s_m_m_autoshop_01 = 0x040EABE3,
   s_m_m_autoshop_02 = 0xF06B849D,
   s_m_m_bouncer_01 = 0x9FD4292D,
   s_m_m_ccrew_01 = 0xC9E5F56B,
   s_m_m_chemsec_01 = 0x2EFEAFD5,
   s_m_m_ciasec_01 = 0x625D6958,
   s_m_m_cntrybar_01 = 0x1A021B83,
   s_m_m_dockwork_01 = 0x14D7B4E0,
   s_m_m_doctor_01 = 0xD47303AC,
   s_m_m_fiboffice_01 = 0xEDBC7546,
   s_m_m_fiboffice_02 = 0x26F067AD,
   s_m_m_fibsec_01 = 0x7B8B434B,
   s_m_m_gaffer_01 = 0xA956BD9E,
   s_m_m_gardener_01 = 0x49EA5685,
   s_m_m_gentransport = 0x1880ED06,
   s_m_m_hairdress_01 = 0x418DFF92,
   s_m_m_highsec_01 = 0xF161D212,
   s_m_m_highsec_02 = 0x2930C1AB,
   s_m_m_janitor = 0xA96BD9EC,
   s_m_m_lathandy_01 = 0x9E80D2CE,
   s_m_m_lifeinvad_01 = 0xDE0077FD,
   s_m_m_linecook = 0xDB9C0997,
   s_m_m_lsmetro_01 = 0x765AAAE4,
   s_m_m_mariachi_01 = 0x7EA4FFA6,
   s_m_m_marine_01 = 0xF2DAA2ED,
   s_m_m_marine_02 = 0xF0259D83,
   s_m_m_migrant_01 = 0xED0CE4C6,
   s_m_m_movalien_01 = 0x64611296,
   s_m_m_movprem_01 = 0xD85E6D28,
   s_m_m_movspace_01 = 0xE7B31432,
   s_m_m_paramedic_01 = 0xB353629E,
   s_m_m_pilot_01 = 0xE75B4B1C,
   s_m_m_pilot_02 = 0xF63DE8E1,
   s_m_m_postal_01 = 0x62599034,
   s_m_m_postal_02 = 0x7367324F,
   s_m_m_prisguard_01 = 0x56C96FC6,
   s_m_m_scientist_01 = 0x4117D39B,
   s_m_m_security_01 = 0xD768B228,
   s_m_m_snowcop_01 = 0x1AE8BB58,
   s_m_m_strperf_01 = 0x795AC7A8,
   s_m_m_strpreach_01 = 0x1C0077FB,
   s_m_m_strvend_01 = 0xCE9113A9,
   s_m_m_trucker_01 = 0x59511A6C,
   s_m_m_ups_01 = 0x9FC37F22,
   s_m_m_ups_02 = 0xD0BDE116,
   s_m_o_busker_01 = 0xAD9EF1BB,
   s_m_y_airworker = 0x62018559,
   s_m_y_ammucity_01 = 0x9E08633D,
   s_m_y_armymech_01 = 0x62CC28E2,
   s_m_y_autopsy_01 = 0xB2273D4E,
   s_m_y_barman_01 = 0xE5A11106,
   s_m_y_baywatch_01 = 0x0B4A6862,
   s_m_y_blackops_01 = 0xB3F3EE34,
   s_m_y_blackops_02 = 0x7A05FA59,
   s_m_y_blackops_03 = 0x5076A73B,
   s_m_y_busboy_01 = 0xD8F9CD47,
   s_m_y_chef_01 = 0x0F977CEB,
   s_m_y_clown_01 = 0x04498DDE,
   s_m_y_construct_01 = 0xD7DA9E99,
   s_m_y_construct_02 = 0xC5FEFADE,
   s_m_y_cop_01 = 0x5E3DA4A4,
   s_m_y_dealer_01 = 0xE497BBEF,
   s_m_y_devinsec_01 = 0x9B557274,
   s_m_y_dockwork_01 = 0x867639D1,
   s_m_y_doorman_01 = 0x22911304,
   s_m_y_dwservice_01 = 0x75D30A91,
   s_m_y_dwservice_02 = 0xF5908A06,
   s_m_y_factory_01 = 0x4163A158,
   s_m_y_fireman_01 = 0xB6B1EDA8,
   s_m_y_garbage = 0xEE75A00F,
   s_m_y_grip_01 = 0x309E7DEA,
   s_m_y_hwaycop_01 = 0x739B1EF5,
   s_m_y_marine_01 = 0x65793043,
   s_m_y_marine_02 = 0x58D696FE,
   s_m_y_marine_03 = 0x72C0CAD2,
   s_m_y_mime = 0x3CDCA742,
   s_m_y_pestcont_01 = 0x48114518,
   s_m_y_pilot_01 = 0xAB300C07,
   s_m_y_prismuscl_01 = 0x5F2113A1,
   s_m_y_prisoner_01 = 0xB1BB9B59,
   s_m_y_ranger_01 = 0xEF7135AE,
   s_m_y_robber_01 = 0xC05E1399,
   s_m_y_sheriff_01 = 0xB144F9B9,
   s_m_y_shop_mask = 0x6E122C06,
   s_m_y_strvend_01 = 0x927F2323,
   s_m_y_swat_01 = 0x8D8F1B10,
   s_m_y_uscg_01 = 0xCA0050E9,
   s_m_y_valet_01 = 0x3B96F23E,
   s_m_y_waiter_01 = 0xAD4C724C,
   s_m_y_winclean_01 = 0x550D8D9D,
   s_m_y_xmech_01 = 0x441405EC,
   s_m_y_xmech_02_mp = 0x69147A0D,
   s_m_y_xmech_02 = 0xBE20FA04,
   u_f_m_corpse_01 = 0x2E140314,
   u_f_m_drowned_01 = 0xD7F37609,
   u_f_m_miranda = 0x414FA27B,
   u_f_m_promourn_01 = 0xA20899E7,
   u_f_o_moviestar = 0x35578634,
   u_f_o_prolhost_01 = 0xC512DD23,
   u_f_y_bikerchic = 0xFA389D4F,
   u_f_y_comjane = 0xB6AA85CE,
   u_f_y_corpse_01 = 0x9C70109D,
   u_f_y_corpse_02 = 0x0D9C72F8,
   u_f_y_hotposh_01 = 0x969B6DFE,
   u_f_y_jewelass_01 = 0xF0D4BE2E,
   u_f_y_mistress = 0x5DCA2528,
   u_f_y_poppymich = 0x23E9A09E,
   u_f_y_princess = 0xD2E3A284,
   u_f_y_spyactress = 0x5B81D86C,
   u_m_m_aldinapoli = 0xF0EC56E2,
   u_m_m_bankman = 0xC306D6F5,
   u_m_m_bikehire_01 = 0x76474545,
   u_m_m_doa_01 = 0x621E6BFD,
   u_m_m_edtoh = 0x2A797197,
   u_m_m_fibarchitect = 0x342333D3,
   u_m_m_filmdirector = 0x2B6E1BB6,
   u_m_m_glenstank_01 = 0x45BB1666,
   u_m_m_griff_01 = 0xC454BCBB,
   u_m_m_jesus_01 = 0xCE2CB751,
   u_m_m_jewelsec_01 = 0xACCCBDB6,
   u_m_m_jewelthief = 0xE6CC3CDC,
   u_m_m_markfost = 0x1C95CB0B,
   u_m_m_partytarget = 0x81F74DE7,
   u_m_m_prolsec_01 = 0x709220C7,
   u_m_m_promourn_01 = 0xCE96030B,
   u_m_m_rivalpap = 0x60D5D6DA,
   u_m_m_spyactor = 0xAC0EA5D8,
   u_m_m_streetart_01 = 0x6C19E962,
   u_m_m_willyfist = 0x90769A8F,
   u_m_o_filmnoir = 0x2BACC2DB,
   u_m_o_finguru_01 = 0x46E39E63,
   u_m_o_taphillbilly = 0x9A1E5E52,
   u_m_o_tramp_01 = 0x6A8F1F9B,
   u_m_y_abner = 0xF0AC2626,
   u_m_y_antonb = 0xCF623A2C,
   u_m_y_babyd = 0xDA116E7E,
   u_m_y_baygor = 0x5244247D,
   u_m_y_burgerdrug_01 = 0x8B7D3766,
   u_m_y_chip = 0x24604B2B,
   u_m_y_corpse_01 = 0x94C2A03F,
   u_m_y_cyclist_01 = 0x2D0EFCEB,
   u_m_y_fibmugger_01 = 0x85B9C668,
   u_m_y_guido_01 = 0xC6B49A2F,
   u_m_y_gunvend_01 = 0xB3229752,
   u_m_y_hippie_01 = 0xF041880B,
   u_m_y_imporage = 0x348065F5,
   u_m_y_juggernaut_01 = 0x90EF5134,
   u_m_y_justin = 0x7DC3908F,
   u_m_y_mani = 0xC8BB1E52,
   u_m_y_militarybum = 0x4705974A,
   u_m_y_paparazzi = 0x5048B328,
   u_m_y_party_01 = 0x36E70600,
   u_m_y_pogo_01 = 0xDC59940D,
   u_m_y_prisoner_01 = 0x7B9B4BC0,
   u_m_y_proldriver_01 = 0x855E36A3,
   u_m_y_rsranger_01 = 0x3C438CD2,
   u_m_y_sbike = 0x6AF4185D,
   u_m_y_staggrm_01 = 0x9194CE03,
   u_m_y_tattoo_01 = 0x94AE2B8C,
   u_m_y_zombie_01 = 0xAC4B4506,
}
PedHexName = table_invert(PedHex)

PedHash = {
    Abigail = 1074457665,
    AbigailCutscene = -1988720319,
    Abner = -257153498,
    Acult01AMM = 1413662315,
    Acult01AMO = 1430544400,
    Acult01AMY = -1251702741,
    Acult02AMO = 1268862154,
    Acult02AMY = -2132435154,
    AfriAmer01AMM = -781039234,
    Agent14 = -67533719,
    Agent14Cutscene = 1841036427,
    AgentCutscene = -680474188,
    AirHostess01SFY = 1567728751,
    AirWorkerSMY = 1644266841,
    AlDiNapoli = -252946718,
    AmandaTownley = 1830688247,
    AmandaTownleyCutscene = -1779492637,
    AmmuCity01SMY = -1643617475,
    AmmuCountrySMM = 233415434,
    Andreas = 1206185632,
    AndreasCutscene = -413773017,
    AnitaCutscene = 117698822,
    AntonB = -815646164,
    AntonCutscene = -1513650250,
    ArmBoss01GMM = -236444766,
    ArmGoon01GMM = -39239064,
    ArmGoon02GMY = -984709238,
    ArmLieut01GMM = -412008429,
    Armoured01 = -839953400,
    Armoured01SMM = -1782092083,
    Armoured02SMM = 1669696074,
    ArmyMech01SMY = 1657546978,
    Ashley = 2129936603,
    AshleyCutscene = 650367097,
    Autopsy01SMY = -1306051250,
    AutoShop01SMM = 68070371,
    Autoshop02SMM = -261389155,
    AviSchwartzman = 939183526,
    AviSchwartzmanCutscene = -1734476390,
    Azteca01GMY = 1752208920,
    BabyD = -636391810,
    BallaEast01GMY = -198252413,
    BallaOrig01GMY = 588969535,
    Ballas01GFY = 361513884,
    BallasOG = -1492432238,
    BallasOGCutscene = -1410400252,
    BallaSout01GMY = 599294057,
    Bankman01 = -1022961931,
    Bankman = -1868718465,
    BankmanCutscene = -1755309778,
    Barman01SMY = -442429178,
    Barry = 797459875,
    BarryCutscene = 1767447799,
    Bartender01SFY = 2014052797,
    Baygor = 1380197501,
    BayWatch01SFY = 1250841910,
    BayWatch01SMY = 189425762,
    Beach01AFM = 808859815,
    Beach01AFY = -945854168,
    Beach01AMM = 1077785853,
    Beach01AMO = -2077764712,
    Beach01AMY = -771835772,
    Beach02AMM = 2021631368,
    Beach02AMY = 600300561,
    Beach03AMY = -408329255,
    BeachVesp01AMY = 2114544056,
    Beachvesp02AMY = -900269486,
    Benny = -994634286,
    BestMen = 1464257942,
    Beverly = -1113448868,
    BeverlyCutscene = -1267809450,
    BevHills01AFM = -1106743555,
    Bevhills01AFY = 1146800212,
    BevHills01AMM = 1423699487,
    BevHills01AMY = 1982350912,
    BevHills02AFM = -1606864033,
    BevHills02AFY = 1546450936,
    BevHills02AMM = 1068876755,
    BevHills02AMY = 1720428295,
    Bevhills03AFY = 549978415,
    BevHills04AFY = 920595805,
    BikeHire01 = 1984382277,
    BikerChic = -96953009,
    BlackOps01SMY = -1275859404,
    BlackOps02SMY = 2047212121,
    BlackOps03SMY = 1349953339,
    Boar = -832573324,
    BoatStaff01F = 848542878,
    BoatStaff01M = -933295480,
    BodyBuild01AFM = 1004114196,
    Bouncer01SMM = -1613485779,
    Brad = -1111799518,
    BradCadaverCutscene = 1915268960,
    BradCutscene = -270159898,
    BreakDance01AMY = 933205398,
    Bride = 1633872967,
    BrideCutscene = -2101379423,
    BurgerDrug = -1954728090,
    BurgerDrugCutscene = -1931689897,
    BusBoy01SMY = -654717625,
    Busicas01AMY = -1697435671,
    Business01AFY = 664399832,
    Business01AMM = 2120901815,
    Business01AMY = -912318012,
    Business02AFM = 532905404,
    Business02AFY = 826475330,
    Business02AMY = -1280051738,
    Business03AFY = -1366884940,
    Business03AMY = -1589423867,
    Business04AFY = -1211756494,
    Busker01SMO = -1382092357,
    Car3Guy1 = -2063996617,
    Car3Guy1Cutscene = 71501447,
    Car3Guy2 = 1975732938,
    Car3Guy2Cutscene = 327394568,
    CarBuyerCutscene = -1932625649,
    Casey = -520477356,
    CaseyCutscene = -359228352,
    Cat = 1462895032,
    CCrew01SMM = -907676309,
    Chef01SMY = 261586155,
    Chef2 = -2054645053,
    Chef2Cutscene = -1369710022,
    Chef = 1240128502,
    ChefCutscene = -1555576182,
    ChemSec01SMM = 788443093,
    ChemWork01GMM = -166363761,
    ChiBoss01GMM = -1176698112,
    ChickenHawk = -1430839454,
    ChiCold01GMM = 275618457,
    ChiGoon01GMM = 2119136831,
    ChiGoon02GMM = -9308122,
    Chimp = -1469565163,
    ChinGoonCutscene = -1463670378,
    Chip = 610290475,
    Chop = 351016938,
    CIASec01SMM = 1650288984,
    Claude01 = -1057787465,
    Clay = 1825562762,
    ClayCutscene = -607414220,
    ClayPain = -1660909656,
    Cletus = -429715051,
    CletusCutscene = -890640939,
    Clown01SMY = 71929310,
    CntryBar01SMM = 436345731,
    ComJane = -1230338610,
    Construct01SMY = -673538407,
    Construct02SMY = -973145378,
    Cop01SFY = 368603149,
    Cop01SMY = 1581098148,
    CopCutscene = -1699520669,
    Cormorant = 1457690978,
    Corpse01 = 773063444,
    Corpse02 = 228356856,
    Cow = -50684386,
    Coyote = 1682622302,
    CrisFormage = 678319271,
    CrisFormageCutscene = -1041006362,
    Crow = 402729631,
    CustomerCutscene = -1538297973,
    Cyclist01 = 755956971,
    Cyclist01amy = -37334073,
    Dale = 1182012905,
    DaleCutscene = 216536661,
    DaveNorton = 365775923,
    DaveNortonCutscene = -2054740852,
    Dealer01SMY = -459818001,
    DebraCutscene = -321892375,
    Deer = -664053099,
    Denise = -2113195075,
    DeniseCutscene = 1870669624,
    DeniseFriendCutscene = -1249041111,
    Devin = 1952555184,
    DevinCutscene = 788622594,
    DevinSec01SMY = -1688898956,
    DHill01AMY = -12678997,
    DoaMan = 1646160893,
    DockWork01SMM = 349680864,
    DockWork01SMY = -2039072303,
    Doctor01SMM = -730659924,
    Dolphin = -1950698411,
    Dom = -1674727288,
    DomCutscene = 1198698306,
    Doorman01SMY = 579932932,
    DownTown01AFM = 1699403886,
    DownTown01AMY = 766375082,
    Dreyfuss = -628553422,
    DreyfussCutscene = 1012965715,
    DrFriedlander = -872673803,
    DrFriedlanderCutscene = -1549575121,
    Drowned = 1943971979,
    DWService01SMY = 1976765073,
    DWService02SMY = -175076858,
    EastSA01AFM = -1656894598,
    EastSA01AFY = -173013091,
    EastSA01AMM = -106498753,
    Eastsa01AMY = -1538846349,
    EastSA02AFM = 1674107025,
    EastSA02AFY = 70821038,
    EastSa02AMM = 131961260,
    EastSA02AMY = 377976310,
    EastSA03AFY = 1371553700,
    EdToh = 712602007,
    Epsilon01AFY = 1755064960,
    Epsilon01AMY = 2010389054,
    Epsilon02AMY = -1434255461,
    ExArmy01 = 1161072059,
    Fabien = -795819184,
    FabienCutscene = 1191403201,
    Factory01SFY = 1777626099,
    Factory01SMY = 1097048408,
    FamCA01GMY = -398748745,
    FamDD01 = 866411749,
    FamDNF01GMY = -613248456,
    FamFor01GMY = -2077218039,
    Families01GFY = 1309468115,
    Farmer01AMM = -1806291497,
    FatBla01AFM = -88831029,
    FatCult01AFM = -1244692252,
    FatLatin01AMM = 1641152947,
    FatWhite01AFM = 951767867,
    FBISuit01 = 988062523,
    FBISuit01Cutscene = 1482427218,
    FemBarberSFM = 373000027,
    FIBArchitect = 874722259,
    FIBMugger01 = -2051422616,
    FIBOffice01SMM = -306416314,
    FIBOffice02SMM = 653289389,
    FIBSec01 = 1558115333,
    FIBSec01SMM = 2072724299,
    FilmDirector = 728636342,
    FilmNoir = 732742363,
    FinGuru01 = 1189322339,
    Fireman01SMY = -1229853272,
    Fish = 802685111,
    Fitness01AFY = 1165780219,
    Fitness02AFY = 331645324,
    Floyd = -1313761614,
    FloydCutscene = 103106535,
    FosRepCutscene = 466359675,
    Franklin = -1692214353,
    FreemodeFemale01 = -1667301416,
    FreeModeMale01 = 1885233650,
    G = -2078561997,
    Gaffer01SMM = -1453933154,
    GarbageSMY = -294281201,
    Gardener01SMM = 1240094341,
    Gay01AMY = -775102410,
    Gay02AMY = -1519253631,
    GCutscene = -1567723049,
    GenFat01AMM = 115168927,
    GenFat02AMM = 330231874,
    GenHot01AFY = 793439294,
    GenStreet01AFO = 1640504453,
    GenStreet01AMO = -1386944600,
    GenStreet01AMY = -1736970383,
    GenStreet02AMY = 891398354,
    GenTransportSMM = 411102470,
    GlenStank01 = 1169888870,
    Golfer01AFY = 2111372120,
    Golfer01AMM = -1444213182,
    Golfer01AMY = -685776591,
    Griff01 = -1001079621,
    Grip01SMY = 815693290,
    Groom = -20018299,
    GroomCutscene = 2058033618,
    GroveStrDlrCutscene = -396800478,
    GuadalopeCutscene = 261428209,
    Guido01 = -961242577,
    GunVend01 = -1289578670,
    GurkCutscene = -1022036185,
    Hacker = -1715797768,
    HairDress01SMM = 1099825042,
    HammerShark = 1015224100,
    Hao = 1704428387,
    HaoCutscene = -325152996,
    HasJew01AMM = 1809430156,
    HasJew01AMY = -512913663,
    Hen = 1794449327,
    HighSec01SMM = -245247470,
    HighSec02SMM = 691061163,
    Hiker01AFY = 813893651,
    Hiker01AMY = 1358380044,
    HillBilly01AMM = 1822107721,
    HillBilly02AMM = 2064532783,
    Hippie01 = -264140789,
    Hippie01AFY = 343259175,
    Hippy01AMY = 2097407511,
    Hipster01AFY = -2109222095,
    Hipster01AMY = 587703123,
    Hipster02AFY = -1745486195,
    Hipster02AMY = 349505262,
    Hipster03AFY = -1514497514,
    Hipster03AMY = 1312913862,
    Hipster04AFY = 429425116,
    Hooker01SFY = 42647445,
    Hooker02SFY = 348382215,
    Hooker03SFY = 51789996,
    HotPosh01 = -1768198658,
    HughCutscene = 1863555924,
    Humpback = 1193010354,
    Hunter = -837606178,
    HunterCutscene = 1531218220,
    Husky = 1318032802,
    HWayCop01SMY = 1939545845,
    ImpoRage = 880829941,
    ImranCutscene = -482210853,
    Indian01AFO = -1160266880,
    Indian01AFY = 153984193,
    Indian01AMM = -573920724,
    Indian01AMY = 706935758,
    JackHowitzerCutscene = 1153203121,
    Janet = 225287241,
    JanetCutscene = 808778210,
    JanitorCutscene = -1040164288,
    JanitorSMM = -1452549652,
    JayNorris = 2050158196,
    Jesus01 = -835930287,
    JetSki01AMY = 767028979,
    JewelAss01 = -254493138,
    JewelAss = 257763003,
    JewelAssCutscene = 1145088004,
    JewelSec01 = -1395868234,
    JewelThief = -422822692,
    JimmyBoston = -308279251,
    JimmyBostonCutscene = 60192701,
    JimmyDisanto = 1459905209,
    JimmyDisantoCutscene = -1194552652,
    JoeMinuteman = -1105179493,
    JoeMinutemanCutscene = -258122199,
    JohnnyKlebitz = -2016771922,
    JohnnyKlebitzCutscene = -91572095,
    Josef = -518348876,
    JosefCutscene = 1167549130,
    Josh = 2040438510,
    JoshCutscene = 1158606749,
    Juggalo01AFY = -619494093,
    Juggalo01AMY = -1849016788,
    Justin = 2109968527,
    KarenDaniels = -346957479,
    KarenDanielsCutscene = 1269774364,
    KerryMcintosh = 1530648845,
    KillerWhale = -1920284487,
    KorBoss01GMM = 891945583,
    Korean01GMY = 611648169,
    Korean02GMY = -1880237687,
    KorLieut01GMY = 2093736314,
    KTown01AFM = 1388848350,
    KTown01AFO = 1204772502,
    KTown01AMM = -782401935,
    KTown01AMO = 355916122,
    KTown01AMY = 452351020,
    KTown02AFM = 1090617681,
    KTown02AMY = 696250687,
    LamarDavis = 1706635382,
    LamarDavisCutscene = 1162230285,
    Lathandy01SMM = -1635724594,
    Latino01AMY = 321657486,
    Lazlow = -538688539,
    LazlowCutscene = 949295643,
    LesterCrest = 1302784073,
    LesterCrestCutscene = -1248528957,
    LifeInvad01 = 1401530684,
    LifeInvad01Cutscene = 1918178165,
    LifeInvad01SMM = -570394627,
    LifeInvad02 = 666718676,
    LineCookSMM = -610530921,
    Lost01GFY = -44746786,
    Lost01GMY = 1330042375,
    Lost02GMY = 1032073858,
    Lost03GMY = 850468060,
    LSMetro01SMM = 1985653476,
    Magenta = -52653814,
    MagentaCutscene = 1477887514,
    Maid01SFM = -527186490,
    Malibu01AMM = 803106487,
    Mani = -927261102,
    Manuel = -46035440,
    ManuelCutscene = -72125238,
    Mariachi01SMM = 2124742566,
    Marine01SMM = -220552467,
    Marine01SMY = 1702441027,
    Marine02SMM = -265970301,
    Marine02SMY = 1490458366,
    Marine03SMY = 1925237458,
    Markfost = 479578891,
    Marnie = 411185872,
    MarnieCutscene = 1464721716,
    Marston01 = 943915367,
    MartinMadrazoCutscene = 1129928304,
    Maryann = -1552967674,
    MaryannCutscene = 161007533,
    Maude = 1005070462,
    MaudeCutscene = -1127975477,
    MerryWeatherCutscene = 1631478380,
    MethHead01AMY = 1768677545,
    MexBoss01GMM = 1466037421,
    MexBoss02GMM = 1226102803,
    MexCntry01AMM = -578715987,
    MexGang01GMY = -1109568186,
    MexGoon01GMY = 653210662,
    MexGoon02GMY = 832784782,
    MexGoon03GMY = -1773333796,
    MexLabor01AMM = -1302522190,
    Mexthug01AMY = 810804565,
    Michael = 225514697,
    Michelle = -1080659212,
    MichelleCutscene = 1890499016,
    Migrant01SFY = -715445259,
    Migrant01SMM = -317922106,
    MilitaryBum = 1191548746,
    Milton = -886023758,
    MiltonCutscene = -1217776881,
    MimeSMY = 1021093698,
    Miranda = 1095737979,
    Mistress = 1573528872,
    Misty01 = -785842275,
    Molly = -1358701087,
    MollyCutscene = 1167167044,
    Motox01AMY = 1694362237,
    Motox02AMY = 2007797722,
    MountainLion = 307287994,
    MovAlien01 = 1684083350,
    MoviePremFemaleCutscene = 1270514905,
    MoviePremMaleCutscene = -1922568579,
    MovieStar = 894928436,
    MovPrem01SFY = 587253782,
    MovPrem01SMM = -664900312,
    MovSpace01SMM = -407694286,
    MPros01 = 1822283721,
    MrK = -304305299,
    MrKCutscene = -1010001291,
    MrsPhillips = 946007720,
    MrsPhillipsCutscene = -872569905,
    MrsThornhill = 503621995,
    MrsThornhillCutscene = 1334976110,
    MusclBeac01AMY = 1264920838,
    MusclBeac02AMY = -920443780,
    Natalia = -568861381,
    NataliaCutscene = 1325314544,
    NervousRon = -1124046095,
    NervousRonCutscene = 2023152276,
    Nigel = -927525251,
    NigelCutscene = -515400693,
    Niko01 = -287649847,
    OGBoss01AMM = 1746653202,
    OldMan1A = 1906124788,
    OldMan1aCutscene = 518814684,
    OldMan2 = -283816889,
    OldMan2Cutscene = -1728452752,
    Omega = 1625728984,
    OmegaCutscene = -1955548155,
    Oneil = 768005095,
    Orleans = 1641334641,
    OrleansCutscene = -1389097126,
    Ortega = 648372919,
    OrtegaCutscene = -1059388209,
    OscarCutscene = -199280229,
    Paige = 357551935,
    PaigeCutscene = 1528799427,
    Paparazzi01AMM = -322270187,
    Paparazzi = 1346941736,
    Paper = -1717894970,
    PaperCutscene = 1798879480,
    Paramedic01SMM = -1286380898,
    Party01 = 921110016,
    PartyTarget = -2114499097,
    Patricia = -982642292,
    PatriciaCutscene = -544533759,
    PestCont01SMY = 1209091352,
    PestContDriver = 994527967,
    PestContGunman = 193469166,
    Pig = -1323586730,
    Pigeon = 111281960,
    Pilot01SMM = -413447396,
    Pilot01SMY = -1422914553,
    Pilot02SMM = -163714847,
    Pogo01 = -598109171,
    PoloGoon01GMY = 1329576454,
    PoloGoon02GMY = -1561829034,
    Polynesian01AMM = -1445349730,
    Polynesian01AMY = -2088436577,
    Poodle = 1125994524,
    Popov = 645279998,
    PopovCutscene = 1635617250,
    PoppyMich = 602513566,
    PornDudesCutscene = 793443893,
    Postal01SMM = 1650036788,
    Postal02SMM = 1936142927,
    Priest = 1681385341,
    PriestCutscene = 1299047806,
    Princess = -756833660,
    PrisGuard01SMM = 1456041926,
    PrisMuscl01SMY = 1596003233,
    Prisoner01 = 2073775040,
    Prisoner01SMY = -1313105063,
    PrologueDriver = -2057423197,
    PrologueDriverCutscene = -267695653,
    PrologueHostage01 = -988619485,
    PrologueHostage01AFM = 379310561,
    PrologueHostage01AMM = -1760377969,
    PrologueMournFemale01 = -1576494617,
    PrologueMournMale01 = -829029621,
    PrologueSec01 = 1888624839,
    PrologueSec01Cutscene = 2141384740,
    PrologueSec02 = 666086773,
    PrologueSec02Cutscene = 512955554,
    Pug = 1832265812,
    Rabbit = -541762431,
    RampGang = -449965460,
    RampGangCutscene = -1031795266,
    RampHic = 1165307954,
    RampHicCutscene = -2054384456,
    RampHipster = -554721426,
    RampHipsterCutscene = 569740212,
    RampMarineCutscene = 1634506681,
    RampMex = -424905564,
    RampMexCutscene = -162605104,
    Ranger01SFY = -1614285257,
    Ranger01SMY = -277793362,
    Rashkovsky = 940326374,
    RashkovskyCutscene = 411081129,
    Rat = -1011537562,
    ReporterCutscene = 776079908,
    Retriever = 882848737,
    Rhesus = -1026527405,
    RivalPaparazzi = 1624626906,
    RoadCyc01AMY = -178150202,
    Robber01SMY = -1067576423,
    RoccoPelosi = -709209345,
    RoccoPelosiCutscene = -1436281204,
    Rottweiler = -1788665315,
    RsRanger01AMO = 1011059922,
    Runner01AFY = -951490775,
    Runner01AMY = 623927022,
    Runner02AMY = -2076336881,
    RurMeth01AFY = 1064866854,
    RurMeth01AMM = 1001210244,
    RussianDrunk = 1024089777,
    RussianDrunkCutscene = 1179785778,
    Salton01AFM = -569505431,
    Salton01AFO = -855671414,
    Salton01AMM = 1328415626,
    Salton01AMO = 539004493,
    Salton01AMY = -681546704,
    Salton02AMM = 1626646295,
    Salton03AMM = -1299428795,
    Salton04AMM = -1773858377,
    SalvaBoss01GMY = -1872961334,
    SalvaGoon01GMY = 663522487,
    SalvaGoon02GMY = 846439045,
    SalvaGoon03GMY = 62440720,
    SBikeAMO = 1794381917,
    SCDressy01AFY = -614546432,
    Scientist01SMM = 1092080539,
    ScreenWriter = -1689993,
    ScreenWriterCutscene = -1948177172,
    Scrubs01SFY = -1420211530,
    Seagull = -745300483,
    Security01SMM = -681004504,
    Shepherd = 1126154828,
    Sheriff01SFY = 1096929346,
    Sheriff01SMY = -1320879687,
    ShopHighSFM = -1371020112,
    ShopKeep01 = 416176080,
    ShopLowSFY = -1452399100,
    ShopMaskSMY = 1846684678,
    ShopMidSFY = 1055701597,
    SiemonYetarian = 1283141381,
    SiemonYetarianCutscene = -1064078846,
    Skater01AFY = 1767892582,
    Skater01AMM = -640198516,
    Skater01AMY = -1044093321,
    Skater02AMY = -1342520604,
    Skidrow01AFM = -1332260293,
    SkidRow01AMM = 32417469,
    SnowCop01SMM = 451459928,
    SoCenLat01AMM = 193817059,
    Solomon = -2034368986,
    SolomonCutscene = -154017714,
    SouCent01AFM = 1951946145,
    SouCent01AFO = 1039800368,
    SouCent01AFY = 744758650,
    SouCent01AMM = 1750583735,
    SouCent01AMO = 718836251,
    SouCent01AMY = -417940021,
    SouCent02AFM = -215821512,
    SouCent02AFO = -1519524074,
    SouCent02AFY = 1519319503,
    SouCent02AMM = -1620232223,
    SouCent02AMO = 1082572151,
    SouCent02AMY = -1398552374,
    SouCent03AFY = -2018356203,
    SouCent03AMM = -1948675910,
    SouCent03AMO = 238213328,
    SouCent03AMY = -1007618204,
    SouCent04AMM = -1023672578,
    SouCent04AMY = -1976105999,
    SouCentMC01AFM = -840346158,
    SpyActor = -1408326184,
    SpyActress = 1535236204,
    StagGrm01AMO = -1852518909,
    StBla01AMY = -812470807,
    Stbla02AMY = -1731772337,
    SteveHain = 941695432,
    SteveHainsCutscene = -1528782338,
    Stingray = -1589092019,
    StLat01AMY = -2039163396,
    StLat02AMM = -1029146878,
    Stretch = 915948376,
    StretchCutscene = -1992464379,
    Stripper01Cutscene = -1360365899,
    Stripper01SFY = 1381498905,
    Stripper02Cutscene = -2126242959,
    Stripper02SFY = 1846523796,
    StripperLite = 695248020,
    StripperLiteSFY = 1544875514,
    StrPerf01SMM = 2035992488,
    StrPreach01SMM = 469792763,
    StrPunk01GMY = -48477765,
    StrPunk02GMY = 228715206,
    StrVend01SMM = -829353047,
    StrVend01SMY = -1837161693,
    StWhi01AMY = 605602864,
    StWhi02AMY = 919005580,
    SunBathe01AMY = -1222037748,
    Surfer01AMY = -356333586,
    SWAT01SMY = -1920001264,
    SweatShop01SFM = 824925120,
    SweatShop01SFY = -2063419726,
    Talina = -409745176,
    Tanisha = 226559113,
    TanishaCutscene = 1123963760,
    TaoCheng = -597926235,
    TaoChengCutscene = -2006710211,
    TaosTranslator = 2089096292,
    TaosTranslatorCutscene = 1397974313,
    TapHillBilly = -1709285806,
    Tattoo01AMO = -1800524916,
    Tennis01AFY = 1426880966,
    Tennis01AMM = 1416254276,
    TennisCoach = -1573167273,
    TennisCoachCutscene = 1545995274,
    Terry = 1728056212,
    TerryCutscene = 978452933,
    TigerShark = 113504370,
    TomCutscene = 1776856003,
    TomEpsilon = -847807830,
    TomEpsilonCutscene = -1945119518,
    Tonya = -892841148,
    TonyaCutscene = 1665391897,
    Topless01AFY = -1661836925,
    Tourist01AFM = 1347814329,
    Tourist01AFY = 1446741360,
    Tourist01AMM = -929103484,
    Tourist02AFY = -1859912896,
    TracyDisanto = -566941131,
    TracyDisantoCutScene = 101298480,
    TrafficWarden = 1461287021,
    TrafficWardenCutscene = -567724045,
    Tramp01 = 1787764635,
    Tramp01AFM = 1224306523,
    Tramp01AMM = 516505552,
    Tramp01AMO = 390939205,
    TrampBeac01AFM = -1935621530,
    TrampBeac01AMM = 1404403376,
    TranVest01AMM = -521758348,
    TranVest02AMM = -150026812,
    Trevor = -1686040670,
    Trucker01SMM = 1498487404,
    TylerDixon = 1382414087,
    UndercoverCopCutscene = -277325206,
    UPS01SMM = -1614577886,
    UPS02SMM = -792862442,
    USCG01SMY = -905948951,
    Vagos01GFY = 1520708641,
    VagosFun01 = -995747907,
    VagosSpeak = -100858228,
    VagosSpeakCutscene = 1224690857,
    Valet01SMY = 999748158,
    VinDouche01AMY = -1047300121,
    Vinewood01AFY = 435429221,
    VineWood01AMY = 1264851357,
    Vinewood02AFY = -625565461,
    VineWood02AMY = 1561705728,
    Vinewood03AFY = 933092024,
    Vinewood03AMY = 534725268,
    Vinewood04AFY = -85696186,
    Vinewood04AMY = 835315305,
    Wade = -1835459726,
    WadeCutscene = -765011498,
    Waiter01SMY = -1387498932,
    WeiCheng = -1427838341,
    WeiChengCutscene = 819699067,
    Westy = -1384627013,
    WillyFist = -1871275377,
    WinClean01SMY = 1426951581,
    XMech01SMY = 1142162924,
    XMech02SMY = -1105135100,
    Yoga01AFY = -1004861906,
    Yoga01AMY = -1425378987,
    Zimbor = 188012277,
    ZimborCutscene = -357782800,
    Zombie01 = -1404353274
}
PedHashName = table_invert(PedHash)




Prop = {
    "basic_style_set",
    "bong_and_wine",
    "branded_style_set",
    "Bunker",
    "bunker_style_a",
    "bunker_style_b",
    "bunker_style_c",
    "burgershot_yoga",
    "car_floor_hatch",
    "Cash_large",
    "Cash_medium",
    "cash_set_01",
    "cash_set_02",
    "cash_set_03",
    "cash_set_04",
    "cash_set_05",
    "cash_set_06",
    "cash_set_07",
    "cash_set_08",
    "cash_set_09",
    "cash_set_10",
    "cash_set_11",
    "cash_set_12",
    "cash_set_13",
    "cash_set_14",
    "cash_set_15",
    "cash_set_16",
    "cash_set_17",
    "cash_set_18",
    "cash_set_19",
    "cash_set_20",
    "cash_set_21",
    "cash_set_22",
    "cash_set_23",
    "cash_set_24",
    "Cash_small",
    "Cash_stash1",
    "Cash_stash2",
    "Cash_stash3",
    "chair01",
    "chair02",
    "chair03",
    "chair04",
    "chair05",
    "chair06",
    "chair07",
    "ClothesLowCHEAP",
    "ClothesLowHipster",
    "clutter",
    "coke_cut_01",
    "coke_cut_02",
    "coke_cut_03",
    "coke_cut_04",
    "coke_cut_05",
    "coke_large",
    "coke_medium",
    "coke_press_basic",
    "coke_press_upgrade",
    "coke_small",
    "coke_stash1",
    "coke_stash2",
    "coke_stash3",
    "control_1",
    "control_2",
    "control_3",
    "counterfeit_cashpile100a",
    "counterfeit_cashpile100b",
    "counterfeit_cashpile100c",
    "counterfeit_cashpile100d",
    "counterfeit_cashpile10a",
    "counterfeit_cashpile10b",
    "counterfeit_cashpile10c",
    "counterfeit_cashpile10d",
    "counterfeit_cashpile20a",
    "counterfeit_cashpile20b",
    "counterfeit_cashpile20c",
    "counterfeit_cashpile20d",
    "counterfeit_large",
    "counterfeit_low_security",
    "counterfeit_medium",
    "counterfeit_security",
    "counterfeit_setup",
    "counterfeit_small",
    "counterfeit_standard_equip",
    "counterfeit_standard_equip_no_prod",
    "counterfeit_stash1",
    "counterfeit_stash2",
    "counterfeit_stash3",
    "counterfeit_upgrade_equip",
    "counterfeit_upgrade_equip_no_prod",
    "csr_afterMissionA",
    "csr_afterMissionB",
    "csr_beforeMission",
    "csr_inMission",
    "Decorative_01",
    "Decorative_01",
    "Decorative_02",
    "Decorative_02",
    "DJ_01_Lights_01",
    "DJ_01_Lights_02",
    "DJ_01_Lights_03",
    "DJ_01_Lights_04",
    "DJ_02_Lights_01",
    "DJ_02_Lights_02",
    "DJ_02_Lights_03",
    "DJ_02_Lights_04",
    "DJ_03_Lights_01",
    "DJ_03_Lights_02",
    "DJ_03_Lights_03",
    "DJ_03_Lights_04",
    "DJ_04_Lights_01",
    "DJ_04_Lights_02",
    "DJ_04_Lights_03",
    "DJ_04_Lights_04",
    "door_blocker",
    "dryera_off",
    "dryera_on",
    "dryera_open",
    "dryerb_off",
    "dryerb_on",
    "dryerb_open",
    "dryerc_off",
    "dryerc_on",
    "dryerc_open",
    "dryerd_off",
    "dryerd_on",
    "dryerd_open",
    "equipment_basic",
    "equipment_basic",
    "equipment_upgrade",
    "equipment_upgrade",
    "Facility",
    "floor_vinyl_01",
    "floor_vinyl_02",
    "floor_vinyl_03",
    "floor_vinyl_04",
    "floor_vinyl_05",
    "floor_vinyl_06",
    "floor_vinyl_07",
    "floor_vinyl_08",
    "floor_vinyl_09",
    "floor_vinyl_10",
    "floor_vinyl_11",
    "floor_vinyl_12",
    "floor_vinyl_13",
    "floor_vinyl_14",
    "floor_vinyl_15",
    "floor_vinyl_16",
    "floor_vinyl_17",
    "floor_vinyl_18",
    "floor_vinyl_19",
    "franklin_settled",
    "franklin_unpacking",
    "Furnishings_01",
    "Furnishings_01",
    "Furnishings_02",
    "Furnishings_02",
    "garage_decor_01",
    "garage_decor_02",
    "garage_decor_03",
    "garage_decor_04",
    "gold_bling",
    "Gun_Locker",
    "Gun_Locker",
    "gun_locker_upgrade",
    "gun_range_blocker_set",
    "gun_range_lights",
    "Gun_schematic_set",
    "gun_wall_blocker",
    "GunClubWallHooks",
    "GunStoreHooks",
    "Hospital",
    "Hospitaldoorsanim",
    "Hospitaldoorsfixed",
    "id_large",
    "id_medium",
    "id_small",
    "id_stash1",
    "id_stash2",
    "id_stash3",
    "Int_03_ba_bikemod",
    "Int_03_ba_Design_01",
    "Int_03_ba_Design_02",
    "Int_03_ba_Design_03",
    "Int_03_ba_Design_04",
    "Int_03_ba_Design_05",
    "Int_03_ba_Design_06",
    "Int_03_ba_Design_07",
    "Int_03_ba_Design_08",
    "Int_03_ba_Design_09",
    "Int_03_ba_Design_10",
    "Int_03_ba_Design_11",
    "Int_03_ba_Design_12",
    "Int_03_ba_Design_13",
    "Int_03_ba_Design_14",
    "Int_03_ba_Design_15",
    "Int_03_ba_Design_16",
    "Int_03_ba_Design_17",
    "Int_03_ba_Design_18",
    "Int_03_ba_Design_19",
    "Int_03_ba_Design_20",
    "Int_03_ba_Design_21",
    "Int_03_ba_Design_22",
    "Int_03_ba_Design_23",
    "Int_03_ba_Design_24",
    "Int_03_ba_Design_25",
    "Int_03_ba_drone",
    "Int_03_ba_Light_Rig1",
    "Int_03_ba_Light_Rig2",
    "Int_03_ba_Light_Rig3",
    "Int_03_ba_Light_Rig4",
    "Int_03_ba_Light_Rig5",
    "Int_03_ba_Light_Rig6",
    "Int_03_ba_Light_Rig7",
    "Int_03_ba_Light_Rig8",
    "Int_03_ba_Light_Rig9",
    "Int_03_ba_Tint",
    "Int_03_ba_weapons_mod",
    "Int01_ba_bar_content",
    "Int01_ba_booze_01",
    "Int01_ba_booze_02",
    "Int01_ba_booze_03",
    "Int01_ba_clubname_01",
    "Int01_ba_clubname_02",
    "Int01_ba_clubname_03",
    "Int01_ba_clubname_04",
    "Int01_ba_clubname_05",
    "Int01_ba_clubname_06",
    "Int01_ba_clubname_07",
    "Int01_ba_clubname_08",
    "Int01_ba_clubname_09",
    "Int01_ba_Clutter",
    "Int01_ba_deliverytruck",
    "Int01_ba_dj01",
    "Int01_ba_dj02",
    "Int01_ba_dj03",
    "Int01_ba_dj04",
    "Int01_ba_dry_ice",
    "Int01_ba_equipment_setup",
    "Int01_ba_equipment_upgrade",
    "Int01_ba_lightgrid_01",
    "int01_ba_lights_screen",
    "Int01_ba_Screen",
    "Int01_ba_security_upgrade",
    "Int01_ba_Style01",
    "Int01_ba_style01_podium",
    "Int01_ba_Style02",
    "Int01_ba_style02_podium",
    "Int01_ba_Style03",
    "Int01_ba_style03_podium",
    "Int01_ba_trad_lights",
    "Int01_ba_trophy01",
    "Int01_ba_trophy02",
    "Int01_ba_trophy03",
    "Int01_ba_trophy04",
    "Int01_ba_trophy05",
    "Int01_ba_trophy07",
    "Int01_ba_trophy08",
    "Int01_ba_trophy09",
    "Int01_ba_trophy10",
    "Int01_ba_trophy11",
    "Int01_ba_Worklamps",
    "Int02_ba_Cash_EQP",
    "Int02_ba_Cash01",
    "Int02_ba_Cash02",
    "Int02_ba_Cash03",
    "Int02_ba_Cash04",
    "Int02_ba_Cash05",
    "Int02_ba_Cash06",
    "Int02_ba_Cash07",
    "Int02_ba_Cash08",
    "Int02_ba_clutterstuff",
    "Int02_ba_coke_EQP",
    "Int02_ba_coke01",
    "Int02_ba_coke02",
    "Int02_ba_DeskPC",
    "Int02_ba_equipment_upgrade",
    "Int02_ba_FanBlocker01",
    "Int02_ba_floor01",
    "Int02_ba_floor02",
    "Int02_ba_floor03",
    "Int02_ba_floor04",
    "Int02_ba_floor05",
    "Int02_ba_Forged_EQP",
    "Int02_ba_Forged01",
    "Int02_ba_Forged02",
    "Int02_ba_Forged03",
    "Int02_ba_Forged04",
    "Int02_ba_Forged05",
    "Int02_ba_Forged06",
    "Int02_ba_Forged07",
    "Int02_ba_Forged08",
    "Int02_ba_Forged09",
    "Int02_ba_Forged10",
    "Int02_ba_Forged11",
    "Int02_ba_Forged12",
    "Int02_ba_garage_blocker",
    "Int02_ba_meth_EQP",
    "Int02_ba_meth01",
    "Int02_ba_meth02",
    "Int02_ba_meth03",
    "Int02_ba_meth04",
    "Int02_ba_sec_desks_L1",
    "Int02_ba_sec_desks_L2345",
    "Int02_ba_sec_upgrade_desk",
    "Int02_ba_sec_upgrade_desk02",
    "Int02_ba_sec_upgrade_grg",
    "Int02_ba_sec_upgrade_strg",
    "Int02_ba_storage_blocker",
    "Int02_ba_truckmod",
    "Int02_ba_truckmod",
    "Int02_ba_Weed_EQP",
    "Int02_ba_Weed01",
    "Int02_ba_Weed02",
    "Int02_ba_Weed03",
    "Int02_ba_Weed04",
    "Int02_ba_Weed05",
    "Int02_ba_Weed06",
    "Int02_ba_Weed07",
    "Int02_ba_Weed08",
    "Int02_ba_Weed09",
    "Int02_ba_Weed10",
    "Int02_ba_Weed11",
    "Int02_ba_Weed12",
    "Int02_ba_Weed13",
    "Int02_ba_Weed14",
    "Int02_ba_Weed15",
    "Int02_ba_Weed16",
    "interior_basic",
    "interior_upgrade",
    "Jewel_Gasmasks",
    "layer_debra_pic",
    "layer_mess_A",
    "layer_mess_B",
    "layer_mess_C",
    "layer_sextoys_a",
    "layer_torture",
    "layer_wade_sh*t",
    "layer_whiskey",
    "light_growtha_stage23_standard",
    "light_growtha_stage23_upgrade",
    "light_growthb_stage23_standard",
    "light_growthb_stage23_upgrade",
    "light_growthc_stage23_standard",
    "light_growthc_stage23_upgrade",
    "light_growthd_stage23_standard",
    "light_growthd_stage23_upgrade",
    "light_growthe_stage23_standard",
    "light_growthe_stage23_upgrade",
    "light_growthf_stage23_standard",
    "light_growthf_stage23_upgrade",
    "light_growthg_stage23_standard",
    "light_growthg_stage23_upgrade",
    "light_growthh_stage23_standard",
    "light_growthh_stage23_upgrade",
    "light_growthi_stage23_standard",
    "light_growthi_stage23_upgrade",
    "light_rigs_off",
    "lighting_option01",
    "lighting_option02",
    "lighting_option03",
    "lighting_option04",
    "lighting_option05",
    "lighting_option06",
    "lighting_option07",
    "lighting_option08",
    "lighting_option09",
    "locked",
    "lower_walls_default",
    "meth_lab_basic",
    "meth_lab_empty",
    "meth_lab_production",
    "meth_lab_security_high",
    "meth_lab_setup",
    "meth_lab_upgrade",
    "meth_large",
    "meth_medium",
    "meth_small",
    "meth_stash1",
    "meth_stash2",
    "meth_stash3",
    "Michael_premier",
    "Mod_Booth",
    "Mod_Booth",
    "money_cutter",
    "Mural_01",
    "Mural_01",
    "Mural_02",
    "Mural_02",
    "Mural_03",
    "Mural_03",
    "Mural_04",
    "Mural_04",
    "Mural_05",
    "Mural_05",
    "Mural_06",
    "Mural_06",
    "Mural_07",
    "Mural_07",
    "Mural_08",
    "Mural_08",
    "Mural_09",
    "Mural_09",
    "Nightclub",
    "NO_Gun_Locker",
    "NO_Gun_Locker",
    "NO_MOD_BOOTH",
    "NO_MOD_BOOTH",
    "numbering_style01_n1",
    "numbering_style01_n2",
    "numbering_style01_n3",
    "numbering_style02_n1",
    "numbering_style02_n2",
    "numbering_style02_n3",
    "numbering_style03_n1",
    "numbering_style03_n2",
    "numbering_style03_n3",
    "numbering_style04_n1",
    "numbering_style04_n2",
    "numbering_style04_n3",
    "numbering_style05_n1",
    "numbering_style05_n2",
    "numbering_style05_n3",
    "numbering_style06_n1",
    "numbering_style06_n2",
    "numbering_style06_n3",
    "numbering_style07_n1",
    "numbering_style07_n2",
    "numbering_style07_n3",
    "numbering_style08_n1",
    "numbering_style08_n2",
    "numbering_style08_n3",
    "numbering_style09_n1",
    "numbering_style09_n2",
    "numbering_style09_n3",
    "office_blocker_set",
    "office_booze",
    "office_chairs",
    "office_upgrade_set",
    "production",
    "production_basic",
    "production_upgrade",
    "progress_flyer",
    "progress_tshirt",
    "progress_tux",
    "security_high",
    "security_high",
    "security_low",
    "security_low",
    "security_upgrade",
    "set_bedroom_blinds_closed",
    "set_bedroom_blinds_open",
    "set_bedroom_clutter",
    "set_bedroom_modern",
    "set_bedroom_tint",
    "set_bedroom_traditional",
    "set_crane_tint",
    "set_floor_1",
    "set_floor_2",
    "set_floor_decal_1",
    "set_floor_decal_2",
    "set_floor_decal_3",
    "set_floor_decal_4",
    "set_floor_decal_5",
    "set_floor_decal_6",
    "set_floor_decal_7",
    "set_floor_decal_8",
    "set_floor_decal_9",
    "set_int_02_aqualungs_complete",
    "set_int_02_burglary_complete",
    "set_int_02_cannon",
    "set_int_02_clutter1",
    "set_int_02_clutter2",
    "set_int_02_clutter3",
    "set_int_02_clutter4",
    "set_int_02_clutter5",
    "set_int_02_crewemblem",
    "set_int_02_daylightrob_complete",
    "set_int_02_decal_01",
    "set_int_02_decal_02",
    "set_int_02_decal_03",
    "set_int_02_decal_04",
    "set_int_02_decal_05",
    "set_int_02_decal_06",
    "set_int_02_decal_07",
    "set_int_02_decal_08",
    "set_int_02_decal_09",
    "set_int_02_flightrecord_complete",
    "set_int_02_forcedentry_complete",
    "set_int_02_lounge1",
    "set_int_02_lounge2",
    "set_int_02_lounge3",
    "set_int_02_no_cannon",
    "set_int_02_no_security",
    "set_int_02_no_sleep",
    "Set_Int_02_outfit_foundry",
    "Set_Int_02_outfit_iaa",
    "Set_Int_02_outfit_khanjali",
    "Set_Int_02_outfit_morgue",
    "Set_Int_02_outfit_paramedic",
    "Set_Int_02_outfit_predator",
    "Set_Int_02_outfit_riot_van",
    "Set_Int_02_outfit_serverfarm",
    "Set_Int_02_outfit_steal_avenger",
    "Set_Int_02_outfit_stromberg",
    "Set_Int_02_outfit_sub_finale",
    "Set_Int_02_outfit_volatol",
    "set_int_02_paramedic_complete",
    "Set_Int_02_Parts_Avenger1",
    "Set_Int_02_Parts_Avenger2",
    "Set_Int_02_Parts_Avenger3",
    "Set_Int_02_Parts_Cheno1",
    "Set_Int_02_Parts_Cheno2",
    "Set_Int_02_Parts_Cheno3",
    "Set_Int_02_Parts_Panther1",
    "Set_Int_02_Parts_Panther2",
    "Set_Int_02_Parts_Panther3",
    "Set_Int_02_Parts_Riot1",
    "Set_Int_02_Parts_Riot2",
    "Set_Int_02_Parts_Riot3",
    "Set_Int_02_Parts_Thruster1",
    "Set_Int_02_Parts_Thruster2",
    "Set_Int_02_Parts_Thruster3",
    "set_int_02_security",
    "set_int_02_shell",
    "set_int_02_sleep",
    "set_int_02_sleep2",
    "set_int_02_sleep3",
    "set_int_02_trophy_iaa",
    "set_int_02_trophy_sub",
    "set_int_02_trophy1",
    "set_lighting_hangar_a",
    "set_lighting_hangar_b",
    "set_lighting_hangar_c",
    "set_lighting_tint_props",
    "set_lighting_wall_neutral",
    "set_lighting_wall_tint01",
    "set_lighting_wall_tint02",
    "set_lighting_wall_tint03",
    "set_lighting_wall_tint04",
    "set_lighting_wall_tint05",
    "set_lighting_wall_tint06",
    "set_lighting_wall_tint07",
    "set_lighting_wall_tint08",
    "set_lighting_wall_tint09",
    "set_modarea",
    "set_office_basic",
    "set_office_modern",
    "set_office_traditional",
    "set_tint_shell",
    "set_up",
    "set_up",
    "shell_tint",
    "showhome_only",
    "shutter_closed",
    "shutter_open",
    "special_chairs",
    "standard_bunker_set",
    "standard_security_set",
    "Stilts_Kitchen_Window",
    "swag_art",
    "swag_art2",
    "swag_art3",
    "swag_booze_cigs",
    "swag_booze_cigs2",
    "swag_booze_cigs3",
    "swag_counterfeit",
    "swag_counterfeit2",
    "swag_counterfeit3",
    "swag_drugbags",
    "swag_drugbags2",
    "swag_drugbags3",
    "swag_drugstatue",
    "swag_drugstatue2",
    "swag_drugstatue3",
    "swag_electronic",
    "swag_electronic2",
    "swag_electronic3",
    "swag_furcoats",
    "swag_furcoats2",
    "swag_furcoats3",
    "swag_gems",
    "swag_gems2",
    "swag_gems3",
    "swag_guns",
    "swag_guns2",
    "swag_guns3",
    "swag_ivory",
    "swag_ivory2",
    "swag_ivory3",
    "swag_jewelwatch",
    "swag_jewelwatch2",
    "swag_jewelwatch3",
    "swag_med",
    "swag_med2",
    "swag_med3",
    "swag_pills",
    "swag_pills2",
    "swag_pills3",
    "swag_silver",
    "swag_silver2",
    "swag_silver3",
    "swap_clean_apt",
    "swap_mrJam_A",
    "swap_mrJam_B",
    "swap_mrJam_C",
    "swap_sofa_A",
    "swap_sofa_B",
    "swap_wade_sofa_A",
    "table_equipment",
    "table_equipment_upgrade",
    "unlocked",
    "upgrade_bunker_set",
    "urban_style_set",
    "V_19_Trevor_Mess",
    "V_24_Trevor_Briefcase1",
    "V_24_Trevor_Briefcase2",
    "V_24_Trevor_Briefcase3",
    "V_26_Michael_Stay1",
    "V_26_Michael_Stay2",
    "V_26_Michael_Stay3",
    "V_26_Trevor_Helmet1",
    "V_26_Trevor_Helmet2",
    "V_26_Trevor_Helmet3",
    "V_35_Body_Armour",
    "V_35_Fireman",
    "V_35_KitBag",
    "V_53_Agency_Blueprint",
    "V_57_Franklin_LEFT",
    "V_57_FranklinStuff",
    "V_57_GangBandana",
    "V_57_Safari",
    "V_FIB02_set_AH3b",
    "V_FIB03_door_light",
    "V_FIB03_set_AH3b",
    "V_FIB04_set_AH3b",
    "V_Michael_bed_Messy",
    "V_Michael_bed_tidy",
    "V_Michael_D_items",
    "V_Michael_D_Moved",
    "V_Michael_FameShame",
    "V_Michael_JewelHeist",
    "V_Michael_L_Items",
    "V_Michael_L_Moved",
    "V_Michael_M_items",
    "V_Michael_M_items_swap",
    "V_Michael_M_moved",
    "V_Michael_plane_ticket",
    "V_Michael_S_items",
    "V_Michael_S_items_swap",
    "V_Michael_Scuba",
    "vehicle_mod",
    "Walls_01",
    "Walls_01",
    "Walls_02",
    "Walls_02",
    "weapons_mod",
    "weed_chairs",
    "weed_drying",
    "weed_growtha_stage1",
    "weed_growtha_stage2",
    "weed_growtha_stage3",
    "weed_growthb_stage1",
    "weed_growthb_stage2",
    "weed_growthb_stage3",
    "weed_growthc_stage1",
    "weed_growthc_stage2",
    "weed_growthc_stage3",
    "weed_growthd_stage1",
    "weed_growthd_stage2",
    "weed_growthd_stage3",
    "weed_growthe_stage1",
    "weed_growthe_stage2",
    "weed_growthe_stage3",
    "weed_growthf_stage1",
    "weed_growthf_stage2",
    "weed_growthf_stage3",
    "weed_growthg_stage1",
    "weed_growthg_stage2",
    "weed_growthg_stage3",
    "weed_growthh_stage1",
    "weed_growthh_stage2",
    "weed_growthh_stage3",
    "weed_growthi_stage1",
    "weed_growthi_stage2",
    "weed_growthi_stage3",
    "weed_hosea",
    "weed_hoseb",
    "weed_hosec",
    "weed_hosed",
    "weed_hosee",
    "weed_hosef",
    "weed_hoseg",
    "weed_hoseh",
    "weed_hosei",
    "Weed_large",
    "weed_low_security",
    "Weed_medium",
    "weed_production",
    "weed_security_upgrade",
    "weed_set_up",
    "Weed_small",
    "weed_standard_equip",
    "Weed_stash1",
    "Weed_stash2",
    "Weed_stash3",
    "weed_upgrade_equip"
}












VehicleConfigFlag = {
    PressingHorn = 1,
    Shooting = 2,
    SirenActive = 4,
    VehicleDead = 8,
    Aiming = 16,
    Driver = 32,
    HasAimData = 64,
    BurnOut = 128,
    ExitingVehicle = 256,
    PlayerDead = 512
}
VehicleConfigFlagName = table_invert(VehicleConfigFlag)

VehicleLicensePlateColor = {
    BlueWhite = 0,
    YellowBlack = 1,
    YellowBlue = 2,
    BlueWhite2 = 3,
    BlueWhite3 = 4,
    Yankton = 5
}
VehicleLicensePlateColorName = table_invert(VehicleLicensePlateColor)

VehicleDoorLockState = {
    None = 0,
    Unlocked = 1,
    Locked = 2,
    LockedForPlayer = 3,
    StickPlayerInside = 4, -- Doesn't allow players to exit the vehicle with the exit vehicle key.
    CanBeBrokenInto = 7, -- Can be broken into the car. If the glass is broken, the value will be set to 1
    CanBeBrokenIntoPersist = 8, -- Can be broken into persist
    CannotBeTriedToEnter = 10, -- Cannot be tried to enter (Nothing happens when you press the vehicle enter key).
}
VehicleDoorLockStateName = table_invert(VehicleDoorLockState)

VehicleHash = {
    adder = 3078201489,
    airbus = 1283517198,
    airtug = 1560980623,
    akula = 1181327175,
    akuma = 1672195559,
    alpha = 767087018,
    alphaz1 = 2771347558,
    alkonost = 3929093893,
    ambulance = 1171614426,
    annihilator2 = 295054921,
    annihilator = 837858166,
    apc = 562680400,
    ardent = 159274291,
    armytanker = 3087536137,
    armytrailer2 = 2657817814,
    armytrailer = 2818520053,
    asbo = 1118611807,
    asea2 = 2487343317,
    asea = 2485144969,
    asterope = 2391954683,
    autarch = 3981782132,
    avarus = 2179174271,
    avenger2 = 408970549,
    avenger = 2176659152,
    avisa = 2588363614,
    bagger = 2154536131,
    baletrailer = 3895125590,
    baller2 = 142944341,
    baller3 = 1878062887,
    baller4 = 634118882,
    baller5 = 470404958,
    baller6 = 666166960,
    baller = 3486135912,
    banshee2 = 633712403,
    banshee = 3253274834,
    barracks2 = 1074326203,
    barracks3 = 630371791,
    barracks = 3471458123,
    barrage = 4081974053,
    bati2 = 3403504941,
    bati = 4180675781,
    benson = 2053223216,
    besra = 1824333165,
    bestiagts = 1274868363,
    bf400 = 86520421,
    bfinjection = 1126868326,
    biff = 850991848,
    bifta = 3945366167,
    bison2 = 2072156101,
    bison3 = 1739845664,
    bison = 4278019151,
    bjxl = 850565707,
    blade = 3089165662,
    blazer2 = 4246935337,
    blazer3 = 3025077634,
    blazer4 = 3854198872,
    blazer5 = 2704629607,
    blazer = 2166734073,
    blimp2 = 3681241380,
    blimp3 = 3987008919,
    blimp = 4143991942,
    blista2 = 1039032026,
    blista3 = 3703315515,
    blista = 3950024287,
    bmx = 1131912276,
    boattrailer = 524108981,
    bobcatxl = 1069929536,
    bodhi2 = 2859047862,
    bombushka = 4262088844,
    boxville2 = 4061868990,
    boxville3 = 121658888,
    boxville4 = 444171386,
    boxville5 = 682434785,
    boxville = 2307837162,
    brawler = 2815302597,
    brickade = 3989239879,
    brioso2 = 1429622905,
    brioso = 1549126457,
    bruiser2 = 2600885406,
    bruiser3 = 2252616474,
    bruiser = 668439077,
    brutus2 = 2403970600,
    brutus3 = 2038858402,
    brutus = 2139203625,
    btype2 = 3463132580,
    btype3 = 3692679425,
    btype = 117401876,
    buccaneer2 = 3281516360,
    buccaneer = 3612755468,
    buffalo2 = 736902334,
    buffalo3 = 237764926,
    buffalo = 3990165190,
    bulldozer = 1886712733,
    bullet = 2598821281,
    burrito2 = 3387490166,
    burrito3 = 2551651283,
    burrito4 = 893081117,
    burrito5 = 1132262048,
    burrito = 2948279460,
    bus = 3581397346,
    buzzard2 = 745926877,
    buzzard = 788747387,
    cablecar = 3334677549,
    caddy2 = 3757070668,
    caddy3 = 3525819835,
    caddy = 1147287684,
    camper = 1876516712,
    calico = 3101054893,
    caracara2 = 2945871676,
    caracara = 1254014755,
    carbonizzare = 2072687711,
    carbonrs = 11251904,
    cargobob2 = 1621617168,
    cargobob3 = 1394036463,
    cargobob4 = 2025593404,
    cargobob = 4244420235,
    cargoplane = 368211810,
    casco = 941800958,
    cavalcade2 = 3505073125,
    cavalcade = 2006918058,
    cerberus2 = 679453769,
    cerberus3 = 1909700336,
    cerberus = 3493417227,
    cheburek = 3306466016,
    cheetah2 = 223240013,
    cheetah = 2983812512,
    chernobog = 3602674979,
    chimera = 6774487,
    chino2 = 2933279331,
    chino = 349605904,
    cliffhanger = 390201602,
    clique = 2728360112,
    club = 2196012677,
    coach = 2222034228,
    cog552 = 704435172,
    cog55 = 906642318,
    cogcabrio = 330661258,
    cognoscenti2 = 3690124666,
    cognoscenti = 2264796000,
    comet2 = 3249425686,
    comet3 = 2272483501,
    comet4 = 1561920505,
    comet5 = 661493923,
    comet6 = 2568944644,
    contender = 683047626,
    coquette2 = 1011753235,
    coquette3 = 784565758,
    coquette4 = 2566281822,
    coquette = 108773431,
    cruiser = 448402357,
    crusader = 321739290,
    cuban800 = 3650256867,
    cutter = 3288047904,
    cyclone = 1392481335,
    cypher = 1755697647,
    daemon2 = 2890830793,
    daemon = 2006142190,
    deathbike2 = 2482017624,
    deathbike3 = 2920466844,
    deathbike = 4267640610,
    defiler = 822018448,
    deluxo = 1483171323,
    deveste = 1591739866,
    deviant = 1279262537,
    diablous2 = 1790834270,
    diablous = 4055125828,
    dilettante2 = 1682114128,
    dilettante = 3164157193,
    dinghy2 = 276773164,
    dinghy3 = 509498602,
    dinghy4 = 867467158,
    dinghy5 = 3314393930,
    dinghy = 1033245328,
    dloader = 1770332643,
    docktrailer = 2154757102,
    docktug = 3410276810,
    dodo = 3393804037,
    dominator2 = 3379262425,
    dominator3 = 3308022675,
    dominator4 = 3606777648,
    dominator5 = 2919906639,
    dominator6 = 3001042683,
    dominator7 = 426742808,
    dominator8 = 736672010,
    dominator = 80636076,
    double = 2623969160,
    drafter = 686471183,
    dubsta2 = 3900892662,
    dubsta3 = 3057713523,
    dubsta = 1177543287,
    dukes2 = 3968823444,
    dukes3 = 2134119907,
    dukes = 723973206,
    dump = 2164484578,
    dune2 = 534258863,
    dune3 = 1897744184,
    dune4 = 3467805257,
    dune5 = 3982671785,
    dune = 2633113103,
    duster = 970356638,
    dynasty = 310284501,
    elegy2 = 3728579874,
    elegy = 196747873,
    ellie = 3027423925,
    emerus = 1323778901,
    emperor2 = 2411965148,
    emperor3 = 3053254478,
    emperor = 3609690755,
    enduro = 1753414259,
    entity2 = 2174267100,
    entityxf = 3003014393,
    esskey = 2035069708,
    euros = 2038480341,
    everon = 2538945576,
    exemplar = 4289813342,
    f620 = 3703357000,
    faction2 = 2504420315,
    faction3 = 2255212070,
    faction = 2175389151,
    fagaloa = 1617472902,
    faggio2 = 55628203,
    faggio3 = 3005788552,
    faggio = 2452219115,
    fbi2 = 2647026068,
    fbi = 1127131465,
    fcr2 = 3537231886,
    fcr = 627535535,
    felon2 = 4205676014,
    felon = 3903372712,
    feltzer2 = 2299640309,
    feltzer3 = 2728226064,
    firetruk = 1938952078,
    fixter = 3458454463,
    flashgt = 3035832600,
    flatbed = 1353720154,
    fmj = 1426219628,
    forklift = 1491375716,
    formula2 = 2334210311,
    formula = 340154634,
    fq2 = 3157435195,
    freecrawler = 4240635011,
    freight = 1030400667,
    freightcar = 184361638,
    freightcar2 = 3186376089,
    freightcont1 = 920453016,
    freightcont2 = 240201337,
    freightgrain = 642617954,
    freighttrailer = 3517691494,
    frogger2 = 1949211328,
    frogger = 744705981,
    fugitive = 1909141499,
    furia = 960812448,
    furoregt = 3205927392,
    fusilade = 499169875,
    futo = 2016857647,
    futo2 = 2787736776,
    gargoyle = 741090084,
    gauntlet2 = 349315417,
    gauntlet3 = 722226637,
    gauntlet4 = 1934384720,
    gauntlet5 = 2172320429,
    gauntlet = 2494797253,
    gb200 = 1909189272,
    gburrito2 = 296357396,
    gburrito = 2549763894,
    glendale2 = 3381377750,
    glendale = 75131841,
    gp1 = 1234311532,
    graintrailer = 1019737494,
    granger = 2519238556,
    gresley = 2751205197,
    growler = 1304459735,
    gt500 = 2215179066,
    guardian = 2186977100,
    habanero = 884422927,
    hakuchou2 = 4039289119,
    hakuchou = 1265391242,
    halftrack = 4262731174,
    handler = 444583674,
    hauler2 = 387748548,
    hauler = 1518533038,
    havok = 2310691317,
    hellion = 3932816511,
    hermes = 15219735,
    hexer = 301427732,
    hotknife = 37348240,
    hotring = 1115909093,
    howard = 3287439187,
    hunter = 4252008158,
    huntley = 486987393,
    hustler = 600450546,
    hydra = 970385471,
    imorgon = 3162245632,
    impaler2 = 1009171724,
    impaler3 = 2370166601,
    impaler4 = 2550461639,
    impaler = 3001042683,
    imperator2 = 1637620610,
    imperator3 = 3539435063,
    imperator = 444994115,
    infernus2 = 2889029532,
    infernus = 418536135,
    ingot = 3005245074,
    innovation = 4135840458,
    insurgent2 = 2071877360,
    insurgent3 = 2370534026,
    insurgent = 2434067162,
    intruder = 886934177,
    issi2 = 3117103977,
    issi3 = 931280609,
    issi4 = 628003514,
    issi5 = 1537277726,
    issi6 = 1239571361,
    issi7 = 1854776567,
    italigtb2 = 3812247419,
    italigtb = 2246633323,
    italigto = 3963499524,
    italirsx = 3145241962,
    jackal = 3670438162,
    jb7002 = 394110044,
    jb700 = 1051415893,
    jester4 = 2712905841,
    jester2 = 3188613414,
    jester3 = 4080061290,
    jester = 2997294755,
    jet = 1058115860,
    jetmax = 861409633,
    journey = 4174679674,
    jugular = 4086055493,
    kalahari = 92612664,
    kamacho = 4173521127,
    kanjo = 409049982,
    khamelion = 544021352,
    khanjali = 2859440138,
    komoda = 3460613305,
    kosatka = 1336872304,
    krieger = 3630826055,
    kuruma2 = 410882957,
    kuruma = 2922118804,
    landstalker2 = 3456868130,
    landstalker = 1269098716,
    lazer = 3013282534,
    le7b = 3062131285,
    lectro = 640818791,
    lguard = 469291905,
    limo2 = 4180339789,
    locust = 3353694737,
    longfin = 1861786828,
    lurcher = 2068293287,
    luxor2 = 3080673438,
    luxor = 621481054,
    lynx = 482197771,
    mamba = 2634021974,
    mammatus = 2548391185,
    manana2 = 1717532765,
    manana = 2170765704,
    manchez2 = 1086534307,
    manchez = 2771538552,
    marquis = 3251507587,
    marshall = 1233534620,
    massacro2 = 3663206819,
    massacro = 4152024626,
    maverick = 2634305738,
    menacer = 2044532910,
    mesa2 = 3546958660,
    mesa3 = 2230595153,
    mesa = 914654722,
    metrotrain = 868868440,
    michelli = 1046206681,
    microlight = 2531412055,
    miljet = 165154707,
    minitank = 3040635986,
    minivan2 = 3168702960,
    minivan = 3984502180,
    mixer2 = 475220373,
    mixer = 3510150843,
    mogul = 3545667823,
    molotok = 1565978651,
    monroe = 3861591579,
    monster3 = 1721676810,
    monster4 = 840387324,
    monster5 = 3579220348,
    monster = 3449006043,
    moonbeam2 = 1896491931,
    moonbeam = 525509695,
    mower = 1783355638,
    mule2 = 3244501995,
    mule3 = 2242229361,
    mule4 = 1945374990,
    mule = 904750859,
    nebula = 3412338231,
    nemesis = 3660088182,
    neo = 2674840994,
    neon = 2445973230,
    nero2 = 1093792632,
    nero = 1034187331,
    nightblade = 2688780135,
    nightshade = 2351681756,
    nightshark = 433954513,
    nimbus = 2999939664,
    ninef2 = 2833484545,
    ninef = 1032823388,
    nokota = 1036591958,
    novak = 2465530446,
    omnis = 3517794615,
    openwheel1 = 1492612435,
    openwheel2 = 1181339704,
    oppressor2 = 2069146067,
    oppressor = 884483972,
    oracle2 = 3783366066,
    oracle = 1348744438,
    osiris = 1987142870,
    outlaw = 408825843,
    packer = 569305213,
    panto = 3863274624,
    paradise = 1488164764,
    paragon2 = 1416466158,
    paragon = 3847255899,
    pariah = 867799010,
    patriot2 = 3874056184,
    patriot = 3486509883,
    patrolboat = 4018222598,
    pbus2 = 345756458,
    pbus = 2287941233,
    pcj = 3385765638,
    penetrator = 2536829930,
    penumbra2 = 3663644634,
    penumbra = 3917501776,
    peyote2 = 2490551588,
    peyote3 = 1107404867,
    peyote = 1830407356,
    pfister811 = 2465164804,
    phantom2 = 2645431192,
    phantom3 = 177270108,
    phantom = 2157618379,
    phoenix = 2199527893,
    picador = 1507916787,
    pigalle = 1078682497,
    police2 = 2667966721,
    police3 = 1912215274,
    police4 = 2321795001,
    police = 2046537925,
    policeb = 4260343491,
    policeold1 = 2758042359,
    policeold2 = 2515846680,
    policet = 456714581,
    polmav = 353883353,
    pony2 = 943752001,
    pony = 4175309224,
    pounder2 = 1653666139,
    pounder = 2112052861,
    prairie = 2844316578,
    pranger = 741586030,
    predator = 3806844075,
    premier = 2411098011,
    previon = 1416471345,
    primo2 = 2254540506,
    primo = 3144368207,
    proptrailer = 356391690,
    prototipo = 2123327359,
    pyro = 2908775872,
    radi = 2643899483,
    raiden = 2765724541,
    raketrailer = 390902130,
    rallytruck = 2191146052,
    rancherxl2 = 1933662059,
    rancherxl = 1645267888,
    rapidgt2 = 1737773231,
    rapidgt3 = 2049897956,
    rapidgt = 2360515092,
    raptor = 3620039993,
    ratbike = 1873600305,
    ratloader2 = 3705788919,
    ratloader = 3627815886,
    rcbandito = 4008920556,
    reaper = 234062309,
    rebel2 = 2249373259,
    rebel = 3087195462,
    rebla = 83136452,
    regina = 4280472072,
    remus = 1377217886,
    rentalbus = 3196165219,
    retinue2 = 2031587082,
    retinue = 1841130506,
    revolter = 3884762073,
    rhapsody = 841808271,
    rhino = 782665360,
    riata = 2762269779,
    riot2 = 2601952180,
    riot = 3089277354,
    ripley = 3448987385,
    rocoto = 2136773105,
    rogue = 3319621991,
    romero = 627094268,
    rrocket = 916547552,
    rt3000 = 3842363289,
    rubble = 2589662668,
    ruffian = 3401388520,
    ruiner2 = 941494461,
    ruiner3 = 777714999,
    ruiner = 4067225593,
    rumpo2 = 2518351607,
    rumpo3 = 1475773103,
    rumpo = 1162065741,
    ruston = 719660200,
    s80 = 3970348707,
    sabregt2 = 223258115,
    sabregt = 2609945748,
    sadler2 = 734217681,
    sadler = 3695398481,
    sanchez2 = 2841686334,
    sanchez = 788045382,
    sanctus = 1491277511,
    sandking2 = 989381445,
    sandking = 3105951696,
    savage = 4212341271,
    savestra = 903794909,
    sc1 = 1352136073,
    scarab2 = 1542143200,
    scarab3 = 3715219435,
    scarab = 3147997943,
    schafter2 = 3039514899,
    schafter3 = 2809443750,
    schafter4 = 1489967196,
    schafter5 = 3406724313,
    schafter6 = 1922255844,
    schlagen = 3787471536,
    schwarzer = 3548084598,
    scorcher = 4108429845,
    scramjet = 3656405053,
    scrap = 2594165727,
    seabreeze = 3902291871,
    seashark2 = 3678636260,
    seashark3 = 3983945033,
    seashark = 3264692260,
    seasparrow2 = 1229411063,
    seasparrow3 = 1593933419,
    seasparrow = 3568198617,
    seminole2 = 2484160806,
    seminole = 1221512915,
    sentinel2 = 873639469,
    sentinel3 = 1104234922,
    sentinel = 1349725314,
    serrano = 1337041428,
    seven70 = 2537130571,
    shamal = 3080461301,
    sheava = 819197656,
    sheriff2 = 1922257928,
    sheriff = 2611638396,
    shotaro = 3889340782,
    skylift = 1044954915,
    slamtruck = 3249056020,
    slamvan2 = 833469436,
    slamvan3 = 1119641113,
    slamvan4 = 2233918197,
    slamvan5 = 373261600,
    slamvan6 = 1742022738,
    slamvan = 729783779,
    sovereign = 743478836,
    specter2 = 1074745671,
    specter = 1886268224,
    speeder2 = 437538602,
    speeder = 231083307,
    speedo2 = 728614474,
    speedo4 = 219613597,
    speedo = 3484649228,
    squaddie = 4192631813,
    squalo = 400514754,
    stafford = 321186144,
    stalion2 = 3893323758,
    stalion = 1923400478,
    stanier = 2817386317,
    starling = 2594093022,
    stinger = 1545842587,
    stingergt = 2196019706,
    stockade3 = 4080511798,
    stockade = 1747439474,
    stratum = 1723137093,
    streiter = 1741861769,
    stretch = 2333339779,
    strikeforce = 1692272545,
    stromberg = 886810209,
    stryder = 301304410,
    stunt = 2172210288,
    submersible2 = 3228633070,
    submersible = 771711535,
    sugoi = 987469656,
    sultan3 = 4003946083,
    sultan2 = 872704284,
    sultan = 970598228,
    sultanrs = 3999278268,
    suntrap = 4012021193,
    superd = 1123216662,
    supervolito2 = 2623428164,
    supervolito = 710198397,
    surano = 384071873,
    surfer2 = 2983726598,
    surfer = 699456151,
    surge = 2400073108,
    swift2 = 1075432268,
    swift = 3955379698,
    swinger = 500482303,
    t20 = 1663218586,
    taco = 1951180813,
    tailgater2 = 3050505892,
    tailgater = 3286105550,
    taipan = 3160260734,
    tampa2 = 3223586949,
    tampa3 = 3084515313,
    tampa = 972671128,
    tanker2 = 1956216962,
    tanker = 3564062519,
    tankercar = 586013744,
    taxi = 3338918751,
    technical2 = 1180875963,
    technical3 = 1356124575,
    technical = 2198148358,
    tempesta = 272929391,
    terbyte = 2306538597,
    tezeract = 1031562256,
    thrax = 1044193113,
    thrust = 1836027715,
    thruster = 1489874736,
    tigon = 2936769864,
    tiptruck2 = 3347205726,
    tiptruck = 48339065,
    titan = 1981688531,
    torero = 1504306544,
    tornado2 = 1531094468,
    tornado3 = 1762279763,
    tornado4 = 2261744861,
    tornado5 = 2497353967,
    tornado6 = 2736567667,
    tornado = 464687292,
    toro2 = 908897389,
    toro = 1070967343,
    toros = 3126015148,
    tourbus = 1941029835,
    towtruck2 = 3852654278,
    towtruck = 2971866336,
    toreador = 1455990255,
    tr2 = 2078290630,
    tr3 = 1784254509,
    tr4 = 2091594960,
    tractor2 = 2218488798,
    tractor3 = 1445631933,
    tractor = 1641462412,
    trailerlarge = 1502869817,
    trailerlogs = 2016027501,
    trailers2 = 2715434129,
    trailers3 = 2236089197,
    trailers4 = 3194418602,
    trailers = 3417488910,
    trailersmall2 = 2413121211,
    trailersmall = 712162987,
    trash2 = 3039269212,
    trash = 1917016601,
    trflat = 2942498482,
    tribike2 = 3061159916,
    tribike3 = 3894672200,
    tribike = 1127861609,
    trophytruck2 = 3631668194,
    trophytruck = 101905590,
    tropic2 = 1448677353,
    tropic = 290013743,
    tropos = 1887331236,
    tug = 2194326579,
    tula = 1043222410,
    tulip = 1456744817,
    turismo2 = 3312836369,
    turismor = 408192225,
    tvtrailer = 2524324030,
    tyrant = 3918533058,
    tyrus = 2067820283,
    utillitruck2 = 887537515,
    utillitruck3 = 2132890591,
    utillitruck = 516990260,
    vacca = 338562499,
    vader = 4154065143,
    vagner = 1939284556,
    vagrant = 740289177,
    valkyrie2 = 1543134283,
    valkyrie = 2694714877,
    vamos = 4245851645,
    vectre = 2754593701,
    velum2 = 1077420264,
    velum = 2621610858,
    verlierer2 = 1102544804,
    verus = 298565713,
    vetir = 2014313426,
    veto = 3437611258,
    veto2 = 2802050217,
    vestra = 1341619767,
    vigero = 3469130167,
    vigilante = 3052358707,
    vindicator = 2941886209,
    virgo2 = 3395457658,
    virgo3 = 16646064,
    virgo = 3796912450,
    viseris = 3903371924,
    visione = 3296789504,
    volatol = 447548909,
    volatus = 2449479409,
    voltic2 = 989294410,
    voltic = 2672523198,
    voodoo2 = 523724515,
    voodoo = 2006667053,
    vortex = 3685342204,
    vstr = 1456336509,
    warrener = 579912970,
    washington = 1777363799,
    wastelander = 2382949506,
    weevil = 1644055914,
    windsor2 = 2364918497,
    windsor = 1581459400,
    winky = 4084658662,
    wolfsbane = 3676349299,
    xa21 = 917809321,
    xls2 = 3862958888,
    xls = 1203490606,
    yosemite2 = 1693751655,
    yosemite3 = 67753863,
    yosemite = 1871995513,
    youga2 = 1026149675,
    youga3 = 1802742206,
    youga = 65402552,
    z190 = 838982985,
    zentorno = 2891838741,
    zhaba = 1284356689,
    zion2 = 3101863448,
    zion3 = 1862507111,
    zion = 3172678083,
    zombiea = 3285698347,
    zombieb = 3724934023,
    zorrusso = 3612858749,
    zr350 = 2436313176,
    zr3802 = 3188846534,
    zr3803 = 2816263004,
    zr380 = 540101442,
    ztype = 758895617
}
VehicleHashName = table_invert(VehicleHash)









WeaponHash = {
    dagger = "",
    bat = "",
    bottle = "",
    crowbar = "",
    unarmed = "",
    flashlight = "",
    golfclub = "",
    hammer = "",
    hatchet = "",
    knuckle = "",
    knife = "",
    machete = "",
    switchblade = "",
    nightstick = "",
    wrench = "",
    battleaxe = "",
    poolcue = "",
    stone_hatchet = "",
    pistol = "",
    pistol_mk2 = "",
    combatpistol = "",
    appistol = "",
    stungun = "",
    pistol50 = "",
    snspistol = "",
    snspistol_mk2 = "",
    heavypistol = "",
    vintagepistol = "",
    flaregun = "",
    marksmanpistol = "",
    revolver = "",
    revolver_mk2 = "",
    doubleaction = "",
    raypistol = "",
    ceramicpistol = "",
    navyrevolver = "",
    microsmg = "",
    smg = "",
    smg_mk2 = "",
    assaultsmg = "",
    combatpdw = "",
    machinepistol = "",
    minismg = "",
    raycarbine = "",
    pumpshotgun = "",
    pumpshotgun_mk2 = "",
    sawnoffshotgun = "",
    assaultshotgun = "",
    bullpupshotgun = "",
    musket = "",
    heavyshotgun = "",
    dbshotgun = "",
    autoshotgun = "",
    assaultrifle = "",
    assaultrifle_mk2 = "",
    carbinerifle = "",
    carbinerifle_mk2 = "",
    advancedrifle = "",
    specialcarbine = "",
    specialcarbine_mk2 = "",
    bullpuprifle = "",
    bullpuprifle_mk2 = "",
    compactrifle = "",
    mg = "",
    combatmg = "",
    combatmg_mk2 = "",
    gusenberg = "",
    sniperrifle = "",
    heavysniper = "",
    heavysniper_mk2 = "",
    marksmanrifle = "",
    marksmanrifle_mk2 = "",
    rpg = "",
    grenadelauncher = "",
    grenadelauncher_smoke = "",
    minigun = "",
    firework = "",
    railgun = "",
    hominglauncher = "",
    compactlauncher = "",
    rayminigun = "",
    grenade = "",
    bzgas = "",
    smokegrenade = "",
    flare = "",
    molotov = "",
    stickybomb = "",
    proxmine = "",
    snowball = "",
    pipebomb = "",
    ball = "",
    petrolcan = "",
    fireextinguisher = "",
    parachute = "",
    hazardcan = ""
}
WeaponHashName = table_invert(WeaponHash)

WeaponPickups = {"pickup_weapon_advancedrifle", "pickup_weapon_appistol", "pickup_weapon_assaultrifle", "pickup_weapon_assaultrifle_mk2",
"pickup_weapon_assaultshotgun", "pickup_weapon_assaultsmg", "pickup_weapon_autoshotgun", "pickup_weapon_ball", "pickup_weapon_bat",
"pickup_weapon_battleaxe", "pickup_weapon_bottle", "pickup_weapon_bullpuprifle", "pickup_weapon_bullpuprifle_mk2", "pickup_weapon_bullpupshotgun",
"pickup_weapon_bzgas", "pickup_weapon_carbinerifle", "pickup_weapon_carbinerifle_mk2", "pickup_weapon_combatmg", "pickup_weapon_combatmg_mk2",
"pickup_weapon_combatpdw", "pickup_weapon_combatpistol", "pickup_weapon_compactlauncher", "pickup_weapon_compactrifle", "pickup_weapon_crowbar",
"pickup_weapon_dagger", "pickup_weapon_dbshotgun", "pickup_weapon_doubleaction", "pickup_weapon_fireextinguisher", "pickup_weapon_firework",
"pickup_weapon_flare", "pickup_weapon_flaregun", "pickup_weapon_flashlight", "pickup_weapon_golfclub", "pickup_weapon_grenade", "pickup_weapon_grenadelauncher",
"pickup_weapon_gusenberg", "pickup_weapon_hammer", "pickup_weapon_hatchet", "pickup_weapon_heavypistol", "pickup_weapon_heavyshotgun", "pickup_weapon_heavysniper",
"pickup_weapon_heavysniper_mk2", "pickup_weapon_hominglauncher", "pickup_weapon_knife", "pickup_weapon_knuckle", "pickup_weapon_machete", "pickup_weapon_machinepistol",
"pickup_weapon_marksmanpistol", "pickup_weapon_marksmanrifle", "pickup_weapon_marksmanrifle_mk2", "pickup_weapon_mg", "pickup_weapon_microsmg", "pickup_weapon_minigun",
"pickup_weapon_minismg", "pickup_weapon_molotov", "pickup_weapon_musket", "pickup_weapon_nightstick", "pickup_weapon_petrolcan", "pickup_weapon_pipebomb",
"pickup_weapon_pistol", "pickup_weapon_pistol50", "pickup_weapon_pistol_mk2", "pickup_weapon_poolcue", "pickup_weapon_proxmine", "pickup_weapon_pumpshotgun",
"pickup_weapon_pumpshotgun_mk2", "pickup_weapon_railgun", "pickup_weapon_raycarbine", "pickup_weapon_rayminigun", "pickup_weapon_raypistol", "pickup_weapon_revolver",
"pickup_weapon_revolver_mk2", "pickup_weapon_rpg", "pickup_weapon_sawnoffshotgun", "pickup_weapon_smg", "pickup_weapon_smg_mk2", "pickup_weapon_smokegrenade",
"pickup_weapon_sniperrifle", "pickup_weapon_snowball", "pickup_weapon_snspistol", "pickup_weapon_snspistol_mk2", "pickup_weapon_specialcarbine",
"pickup_weapon_specialcarbine_mk2", "pickup_weapon_stickybomb", "pickup_weapon_stone_hatchet", "pickup_weapon_stungun", "pickup_weapon_switchblade",
"pickup_weapon_vintagepistol", "pickup_weapon_wrench"}








function vehicle_get_hash(name) return VehicleHash[name] end
function vehicle_get_name(hash) return VehicleHashName[hash] end
function vehicle_get_infos(veh)
	if not veh then return {} end
	local infos = {}
	infos.hash = veh:get_model_hash()
	infos.name = vehicle_get_name(infos.hash)
	infos.licensePlate = veh:get_number_plate_text()
	infos.godmode = veh:get_godmode()
	infos.locked = veh:get_door_lock_state()
	infos.max_speed = veh:get_max_speed()
	infos.bouyance = veh:get_bouyance()
	return infos
end

function vehicle_get_string(veh)
    local infos = vehicle_get_infos(veh)
	-- log("vehicle_get_infos: "..dump(infos))
	local str = infos.name or tostring(veh)
	if infos.hash then str = str .. " (" .. dump(infos.hash) .. ")" end
	if infos.licensePlate then str = str .. " [" .. dump(infos.licensePlate) .. "]" end
	if infos.godmode then str = str .. " * " end
	if infos.locked ~= nil then str = str .. " " .. (infos.locked and "LOCKED" or "UNLOCKED")..": "..dump(infos.locked) end
	if infos.max_speed then str = str .. " speed:" .. dump(infos.max_speed) end
	if infos.bouyance then str = str .. " bouyance:" .. dump(infos.bouyance) end
	return str
end

function vehicle_spawn(modelhash, moreopts,ped)

if not ped and (localplayer == nil or localplayer:get_position() == nil) then  return end
if ped and (ped == nil or ped:get_position() == nil) then  return end

	local mypos = nil
    local heading = nil
	
		if ped then
			mypos = ped:get_position()
			heading = ped:get_heading()
				else
			mypos = localplayer:get_position()
			heading = localplayer:get_heading()
		end
    mypos.x = mypos.x + heading.x * (5) 
    mypos.y = mypos.y + heading.y * (5)
	
	--Source: https://gitlab.com/ExternalMemoryakaLolBobTest/external-menu-gta-5-csgo/-/blob/master/GTA%205%20C++/Hack.cpp

--[[ 	globals.set_int(2725439 + 2, 1)
	globals.set_uint(2725439 + 5, 1)
	globals.set_uint(2725439 + 27, 1)

	if moreopts then

		--globals.set_uint(2725439 + 27 + 1, math_randomnumber(1,9000000)) --VEHICLE_NUMBER_PLATE_TEXT
		
		globals.set_uint(2725439 + 27 + 5, 255) --VEHICLE_PRIMARY_COLOR
		globals.set_uint(2725439 + 27 + 6, 255) --VEHICLE_SECONDARY_COLOR
		globals.set_uint(2725439 + 27 + 7, 255) --VEHICLE_EXTRA_COLOURS
		
		globals.set_int(2725439 + 27 + 8, 255)
		globals.set_int(2725439 + 27 + 10, 5)
		globals.set_int(2725439 + 27 + 12, 4)
		globals.set_int(2725439 + 27 + 13, 8)
		globals.set_int(2725439 + 27 + 14, 6)
		globals.set_int(2725439 + 27 + 15, 3)
		globals.set_int(2725439 + 27 + 16, 4)
		globals.set_int(2725439 + 27 + 17, 13)
		globals.set_int(2725439 + 27 + 18, 8)
		globals.set_int(2725439 + 27 + 19, 5)
		globals.set_int(2725439 + 27 + 20, 255)
		globals.set_int(2725439 + 27 + 21, 3)
		globals.set_int(2725439 + 27 + 22, 6)
		globals.set_int(2725439 + 27 + 23, 10)
		globals.set_int(2725439 + 27 + 24, -1)
		
		globals.set_uint(2725439 + 27 + 59, 2)
		globals.set_int(2725439 + 27 + 62, 255)
		globals.set_int(2725439 + 27 + 63, 0)
		globals.set_int(2725439 + 27 + 64, 0)
		globals.set_int(2725439 + 27 + 65, 2)
		
		globals.set_uint(2725439 + 27 + 67, 1)
		globals.set_uint(2725439 + 27 + 69, 0)
		globals.set_uint(2725439 + 27 + 27, 1)
		
		globals.set_uint(2725439 + 27 + 74, 255) --VEHICLE_NEON_LIGHTS_COLOUR
		globals.set_uint(2725439 + 27 + 75, 255) 
		globals.set_uint(2725439 + 27 + 76, 255) 
		
		globals.set_uint(2725439 + 27 + 68, 1) --GET_CONVERTIBLE_ROOF_STATE
		globals.set_int(2725439 + 27 + 77, 0xF0400000) --CAR OPTIONS
		globals.set_uint(2725439 + 27 + 96, 1)
		globals.set_uint(2725439 + 27 + 97, 1)
		globals.set_uint(2725439 + 27 + 98, 0)
		globals.set_uint(2725439 + 27 + 99, 255)
	end

	globals.set_uint(2725439 + 27 + 70, 0) --VEHICLE_DOOR_LOCK_STATUS (If it is not 0, you cant enter the vehicle).

	globals.set_int(2725439 + 27 + 66, modelhash)

	globals.set_float(2725439 + 7, mypos.x) --Position X
	globals.set_float(2725439 + 7+1, mypos.y) --Position Y
	globals.set_float(2725439 + 7+2, mypos.z)
	--globals.set_float(2725439 + 7+2, -255)

--[[
	globals.set_int(2725439 + 2, 1);
	globals.set_uint(2725439 + 5, 1);
	globals.set_int(2725439 + 27 + 66, modelhash);
	globals.set_float(2725439 + 7, mypos.x);
	globals.set_float(2725439 + 7+1, mypos.y);
	globals.set_float(2725439 + 7+2, -255);
--]]
		-- different type of spawn
   --globals.set_int(2671449 + 44,  modelhash)
   -- globals.set_float(2671449 + 40, mypos.x)
   -- globals.set_float(2671449 + 41, mypos.y)
   -- globals.set_float(2671449 + 42, mypos.z)

   -- globals.set_boolean(2671449 + 39, true)

--]]
	globals.set_int(2725439 + 2, 1);
	globals.set_uint(2725439 + 5, 1);
	globals.set_int(2725439 + 27 + 66, modelhash);
	globals.set_float(2725439 + 7, mypos.x);
	globals.set_float(2725439 + 7+1, mypos.y);
	globals.set_float(2725439 + 7+2, -255);
		
	if moreopts then

		globals.set_uint(2725439 + 27, 1);
		
		--globals.set_uint(2725439 + 27 + 1, math_randomnumber(1,9000000)) --VEHICLE_NUMBER_PLATE_TEXT
			
		globals.set_uint(2725439 + 27 + 5, 10); --VEHICLE_COLOURS
		globals.set_uint(2725439 + 27 + 6, 10);
		globals.set_uint(2725439 + 27 + 7, 10); 
		globals.set_int(2725439 + 27 + 8, 255);--VEHICLE_EXTRA_COLOURS
		
		
		globals.set_int(2725439 + 27 + 10, 5);
		globals.set_int(2725439 + 27 + 12, 4);
		globals.set_int(2725439 + 27 + 13, 8);
		globals.set_int(2725439 + 27 + 14, 6);
		globals.set_int(2725439 + 27 + 15, 3);
		globals.set_int(2725439 + 27 + 16, 4);
		globals.set_int(2725439 + 27 + 17, 13);
		globals.set_int(2725439 + 27 + 18, 8);
			
		globals.set_int(2725439 + 27 + 13, 8);
		globals.set_int(2725439 + 27 + 19, 5);
		globals.set_int(2725439 + 27 + 20, 255);
		globals.set_int(2725439 + 27 + 21, 3);
		globals.set_int(2725439 + 27 + 22, 6);
		globals.set_int(2725439 + 27 + 23, 10);
		globals.set_int(2725439 + 27 + 24, -1);

		globals.set_uint(2725439 + 27 + 59, 2);
		globals.set_int(2725439 + 27 + 62, 255); --VEHICLE_TYRE_SMOKE_COLOR
		globals.set_int(2725439 + 27 + 63, 0);
		globals.set_int(2725439 + 27 + 64, 0);
		globals.set_int(2725439 + 27 + 65, 1); --VEHICLE_WINDOW_TINT
		globals.set_uint(2725439 + 27 + 67, 1); --VEHICLE_LIVERY
		globals.set_uint(2725439 + 27 + 69, 0); --VEHICLE_WHEEL_TYPE
		globals.set_uint(2725439 + 27 + 27, 1); --VEHICLE_TYRE_SMOKE_COLOR
		globals.set_uint(2725439 + 27 + 70, 0); --VEHICLE_DOOR_LOCK_STATUS
		globals.set_uint(2725439 + 27 + 74, 255); --VEHICLE_NEON_LIGHTS_COLOUR
		globals.set_uint(2725439 + 27 + 75, 255); --VEHICLE_NEON_LIGHTS_COLOUR
		globals.set_uint(2725439 + 27 + 76, 255); --VEHICLE_NEON_LIGHTS_COLOUR
		globals.set_uint(2725439 + 27 + 68, 1); --GET_CONVERTIBLE_ROOF_STATE
		globals.set_int(2725439 + 27 + 77, 0xF0400000); --CAR OPTIONS
		
		
		
		globals.set_uint(2725439 + 27 + 96, 1);
		globals.set_uint(2725439 + 27 + 97, 1);
		globals.set_uint(2725439 + 27 + 98, 0);
		globals.set_uint(2725439 + 27 + 99, 255);
		globals.set_uint(2460715 + 27 + 100, 1);


		globals.set_int(2725439 + 27 + 9 + 4, 4); 
		globals.set_int(2725439 + 27 + 9 + 5, 4); 
		globals.set_int(2725439 + 27 + 9 + 6, 4); 
		globals.set_int(2725439 + 27 + 9 + 7, 4); 
		globals.set_int(2725439 + 27 + 9 + 8, 4); 
		globals.set_int(2725439 + 27 + 9 + 9, 4); 
		globals.set_int(2725439 + 27 + 9 + 10, 4); 
		globals.set_int(2725439 + 27 + 9 + 12, 4);  -- ems?
		globals.set_int(2725439 + 27 + 9 + 13, 4); 
		globals.set_int(2725439 + 27 + 9 + 14, 4);--
		globals.set_int(2725439 + 27 + 9 + 15, 4);--
		globals.set_int(2725439 + 27 + 9 + 16, 4);
		globals.set_int(2725439 + 27 + 9 + 18, 1);
		
		
		globals.set_int(2725439 + 27 + 0 , 1);
		
		globals.set_int(2725439 + 27 + 5, 44); -- primary color (pre config)
		globals.set_int(2725439 + 27 + 6, 4); -- secondari color (pre config)
		globals.set_int(2725439 + 27 + 7, -1); -- pearlesent color (pre config)
		globals.set_int(2725439 + 27 + 8, -1); --wheel color
					

		globals.set_int(2725439 + 27 + 7, -1);
		globals.set_int(2725439 + 27 + 8, -1);
		globals.set_int(2725439 + 27 + 10, 16);
		globals.set_int(2725439 + 27 + 11, 11);
		globals.set_int(2725439 + 27 + 12, 2);
		globals.set_int(2725439 + 27 + 13, 4);
		globals.set_int(2725439 + 27 + 14, 7);
		globals.set_int(2725439 + 27 + 17, 8);
		globals.set_int(2725439 + 27 + 18, 1);
		globals.set_int(2725439 + 27 + 19, 5);
		
		globals.set_int(2725439 + 27 + 21, 4); -- ems
		globals.set_int(2725439 + 27 + 22, 6); -- brakes
		globals.set_int(2725439 + 27 + 23, 9); -- TRANSMISSION
		globals.set_int(2725439 + 27 + 24, 58);
		globals.set_int(2725439 + 27 + 25, 13); -- suspension
		globals.set_int(2725439 + 27 + 26, 5); -- armor
		globals.set_int(2725439 + 27 + 27, 1);
		globals.set_int(2725439 + 27 + 28, 1); -- turbooo
		
		globals.set_int(2725439 + 27 + 29, 1);
		globals.set_int(2725439 + 27 + 30, 1);
		globals.set_int(2725439 + 27 + 31, 1);
		globals.set_int(2725439 + 27 + 33, 241); -- wheel type
		globals.set_int(2725439 + 27 + 58, -1);  -- livery
		globals.set_int(2725439 + 27 + 60, -1);
		globals.set_int(2725439 + 27 + 61, -1);
		globals.set_int(2725439 + 27 + 62, 200); -- smoke colors r
		globals.set_int(2725439 + 27 + 63, 200); -- smoke colors g
		globals.set_int(2725439 + 27 + 64, 200); -- smoke colors b
		
		globals.set_int(2725439 + 27 + 74, 200); -- neon colors r
		globals.set_int(2725439 + 27 + 75, 200); -- neon colors g
		globals.set_int(2725439 + 27 + 76, 200); -- neon colors b
		
		globals.set_int(2725439 + 27 + 77, -264240640); -- bulletproof tires bool? en = -264240640 dis = -264241152 or bool true false
		
		
		globals.set_int(2725439 + 27 + 78, -264240640); -- neon dis= = 4194816 en = -264240640 or bool true false
		
		globals.set_int(2725439 + 27 + 64, 200);
		
		globals.set_int(2725439 + 27 + 65, 1); -- limo windows
			
		globals.set_int(2725439 + 27 + 99, 12); --dashboard color (pre config)
		globals.set_int(2725439 + 27 + 100, 4);
		

		

	end

end





-------------------------------------------------------------




--[[

local listty = {}
local olistty = {}

local ulistty = {}
local oulistty = {}

local boollistty = {}
local oboollistty = {}
local numm = 500
local numm2 = 55000
local logoffset = 2671449 + 42 -- faked personal? + 42 im not sure it does not show up for me

logoffset = 2725439 + 27 -- anonymus car at  + 27

function logints()
sleep(0.2)
print("begin")
	olistty = {}
	olistty = listty
	listty = {}

    for i = 0, numm2 do	
	
	   listty[i] = globals.get_int((logoffset + (i-numm)))
	
		local donot = false
		if #olistty > 1 then
		local l1 = olistty[i]
		local l2 = listty[i] 
			if l1 == l2 then 
			donot = true
			end 
			if not donot then
					print("Int " .. logoffset .." + " .. i-numm .. " - " .. olistty[i].. " >>  " .. listty[i])
			
			end
		end
		
		
	end
	
    for i = 0, numm2 do	
	
	   ulistty[i] = globals.get_uint((logoffset  + (i-numm)))
	
		local donotu = false
		local donotul = false
		if #oulistty > 1 then
		local l1 = oulistty[i]
		local l2 = ulistty[i] 
		local lllll = listty[i]

			if l1 == l2 then 
			donotu = true
			end 
			if l2 == lllll then
				donotul = true
			end
			if not donotu and not donotul then
	
					print("Uint " .. logoffset .." + " .. i-numm .. " - " .. oulistty[i].. " >>  " .. ulistty[i])
			end
		end
		
		
	end
	
	--[[	 --how o i get bool and see if one changed?
	for i = 0, numm2 do	

	   boollistty[i] = globals.get_bool((logoffset + (i-numm)))
	
		local donotu = false
		if #oboollistty > 1 then
		local l1 = oboollistty[i]
		local l2 = boollistty[i] 
		if l1 == l2 then donotu = true end 
			if not donotu then
					local booltype = "false"
					local obooltype = "false"
					if oboollistty[i] then obooltype = "true" end
					if boollistty[i] then booltype = "true" end
					print("Bool " .. logoffset .." + " .. i-numm .. " " .. obooltype.. " >>  " .. booltype)
			end
		end

	end
	--]] 	 --how o i get bool and see if one changed?
	
	--[[
	
	
	print("end")
end

menu.register_hotkey(76, function() logints() end) 
-- press l to log difference in ints set in game 
--after spawning a vehicle press l
--then change anything in the spawner and press l to see the differences




--]]



--------------------








function math_distance(vec1, vec2)
	return math.sqrt(((vec2.x - vec1.x)^2) + ((vec2.y - vec1.y)^2) + ((vec2.z - vec1.z)^2))
end
function math_onodot(valu)
	local l = 0 
	local n = math.floor(valu * 10)
	for i = 0, n do
		l = i/10
	end
	return l
end
function math_sqrt(i)
	return i^0.5
end
function math_distancetosqr(vec1, vec2)
	return ((vec2.x - vec1.x)^2) + ((vec2.y - vec1.y)^2) + ((vec2.z - vec1.z)^2)
end
function math_distance2(vec1, vec2)
	return math_sqrt(math_distancetosqr(vec1, vec2))
end 
function math_floor(num)
	return num//1
end
function math_thousand_seperator(value)
	while true do
	   value, k = string.gsub(value, "^(-?%d+)(%d%d%d)", '%1,%2')
	   if (k==0) then
		  break
	   end
	end
	return value
end
function math_round(val, decimal)
	if (decimal) then
	   return math.floor( (val * 10^decimal) + 0.5) / (10^decimal)
	else
	   return math.floor(val+0.5)
	end
end
function math_randomnumber(first,last)

	math.random(); math.random()
	math.random(); math.random()
	if first and last then 
		return math.random(first,last)
	elseif first then
		return math.random(1,first)
	else
		return math.random()
	end
end
-- 
math.random(); math.random(); math.random()











function player_is_player(ped)
	if ped == nil or ped:get_pedtype() >= 4 then
		return false
	end
	return true
end
function player_is_npc(ped)
	if ped == nil or ped:get_pedtype() < 4 then
		return false
	end
	return true
end
function player_get_vehicle(veh)
	for i = 0, 31 do
		ply = player.get_player_ped(i)
		if ply then if ply:get_current_vehicle()==veh then
		return true else return false end end
	end
end
function player_is_modder(ply)
	if not player_is_player(ply) then return false end
	if ply:get_max_health() < 100 then return true end
	if ply:is_in_vehicle() and ply:get_godmode() then return true end
	if ply:get_run_speed() > 1.0 or ply:get_swim_speed() > 1.0 then return true end
	if ply:get_infinite_clip()then return true end --Infinit clip
	if ply:get_no_ragdoll() then return true end --No ragdoll
	if ply:get_seatbelt() and ply:is_in_vehicle() then return true end
	if ply:get_current_weapon() and ply:get_current_weapon():get_current_ammo() > 0 and ply:get_infinite_ammo() then return true end --Infinite ammo
	return false
end

function player_set_ped_model(hash)
	if hash == nil then print("[ERROR] player_set_ped_model: hash is nil") end
	globals.set_int(Global["ChangeModelTrigger"], 1)
	globals.set_int(Global["ChangeModel"], hash)
	sleep(0.01)
	globals.set_int(Global["ChangeModelTrigger"], 0)
end
function player_get_position(player, floor)
	local pos = player:get_position()
	local head = player:get_rotation()
	if floor then
		pos.x = math.floor(pos.x)
		pos.y = math.floor(pos.y)
		pos.z = math.floor(pos.z)
		head.x = math.floor(head.x)
		head.y = math.floor(head.y)
		head.z = math.floor(head.z)
	end
	return pos.x,pos.y,pos.z,head.x,head.y,head.z
end
function player_position_string(player)
	local x,y,z,hx,hy,hz = player_get_position(player, true)
	return "X: "..x.." Y: "..y.." Z: "..z
end
function player_rotation_string(player)
	local x,y,z,hx,hy,hz = player_get_position(player, true)
	return "X: "..hx.." Y: "..hy.." Z: "..hz
end














local function global_toggle(var)
	if globals.get_boolean(var) then globals.set_boolean(var, false) else globals.set_boolean(var, true) end
end






function catch(what)
    return what[1]
 end
 
 function try(what)
    status, result = pcall(what[1])
    if not status then
       what[2](result)
    end
    return result
 end

-- local filename = function()
--     local str = debug.getinfo(2, "S").source:sub(2)
--     return str:match("^.*/(.*).lua$") or str
-- end
debug = true
function log(item, _debug)
    -- filename().."> "
    -- time = "["..os.date("!%Y-%m-%dT%TZ").."] "
    -- res = {}
    -- for i,item in arg do
    -- table.insert(res, item)
    -- end
    -- print(table.concat(res, " | "))    
    if not _debug or debug then print(dump(item)) end
end
function trydump(item)
    try {
        function()
            if item == nil then return "nil" end
            if type(item) == "table" then
                return table_dump(item)
            elseif type(item) == "bool" then
                if item == true then return "true" elseif item == false then return "false" end
            end
            return tostring(item)
        end,
        catch {
           function(error)
              return '(ERR:'..error..')'
           end
        }
     }
end
function dump(item)
    if item == nil then return "nil" end
    if type(item) == "table" then
        return table_dump(item)
    elseif type(item) == "bool" then
        if item == true then return "true" elseif item == false then return "false" end
    end
    return tostring(item)
end













function menu_add_global_toggle(var, title)
    log("utils/menu > menu_add_global_toggle: " .. dump(var) .. " | " .. dump(title))
    menu.add_toggle(title, function() return globals.get_boolean(var) end, function(var) global_toggle(var) end)
end
function menu_add_enum_range(enum, title, sort, action_callback, default_key_callback, _menu)
    log("utils/menu > menu_add_enum_range: " .. tostring(enum) .. " | " .. dump(title) .. " | " .. dump(sort) .. " | " .. dump(action_callback) .. " | " .. dump(default_key_callback))
    local enum_keys = table_get_keys(enum)
    local enum_keys_len = table_count(enum_keys)
    local enum_values = table_get_values(enum)
    local function default_index() return table_index_of(enum_keys, default_key_callback()) or 1 end
    local i = default_index()
    local function curkey() return enum_keys[i] end
    local function curval() return enum_values[i] end
    local function set_title()
        local title = title .. " | "
        if i == nil then i = default_index() end
        if i < enum_keys_len then title = title .. " < " end
        title = title .. enum_keys[i]
        if i > 0 then title = title .. " > " end
        return title
    end
    local function santize_index(i)
        if i == nil then i = default_index() end
        if i < 1 then i = 1 end
        if i > enum_keys_len then i = enum_keys_len end
        return i
    end
    local function next_item()
        i = santize_index(i)
        i = santize_index(table_index_of(enum_keys, curkey())+1)
        return set_title()
    end
    local function previous_item()
        i = santize_index(i)
        i = santize_index(table_index_of(enum_keys, curkey())-1)
        return set_title()
    end
    if _menu then _menu:add_bare_item(title, set_title, function() action_callback(curval()) end, previous_item, next_item)
    else menu.add_bare_item(title, set_title, function() action_callback(curval()) end, previous_item, next_item) end
end
function menu_centered_text(str)
    local len = 30 - math.floor(string.len(str) / 2 + 0.5)
    local text = ""
    for i = 0, len do
        text = text.." "
    end
    return text..str
end










function string.startsWith(String,Start)
    if String == nil or Start == nil then return false end
    return string.sub(String,1,string.len(Start))==Start
 end
function string.toTitleCase(str) return string.gsub(" "..str, "%W%l", string.upper):sub(2) end











function weapon_get_hash(name)
    return WeaponHash[name] or joaat(name)
end
function weapon_get_name(hash)
    return WeaponHashName[hash] or "Unknown"
end
function weapon_get_infos(gun)
	if not gun then return {} end
	local infos = {}
	infos.hash = gun:get_model_hash()
	infos.name = weapon_get_name(infos.hash)
	infos.ammo = gun:get_current_ammo()
	infos.max_ammo = gun:get_max_mp_ammo()
	return infos
end

function weapon_get_string(gun)
    local infos = weapon_get_infos(gun)
	-- log("weapon_get_infos: "..dump(infos))
	local str = infos["name"] or tostring(gun)
	if infos.hash then str = str .. " (" .. dump(infos.hash) .. ")" end
	if infos.ammo then str = str .. " ["..dump(infos.ammo).."/"..dump(infos.max_ammo)"]" end
	return str
end



function weapon_spawn(weapon)
	local mypos = localplayer:get_position()
	
	--CODE TO CREATE AN AMBIENT PICKUP--
	
	globals.set_uint(2783351, 1)
	globals.set_int(2783345  + 1, 1337) -- 1337 is the amount of money just to identify the pickup later
	globals.set_float(2783345  + 3, mypos.x + 0)
	globals.set_float(2783345  + 4, mypos.y + 0)
	globals.set_float(2783345  + 5, mypos.z + 5)
	globals.set_uint(4528329 + 1 + (globals.get_int(2783345) * 85) + 66 + 2, 2)
	
	--Source: https://gitlab.com/ExternalMemoryakaLolBobTest/external-menu-gta-5-csgo/-/blob/master/GTA%205%20C++/Hack.cpp
	
	--END OF CODE TO CREATE AN AMBIENT PICKUP--
	
	sleep(0.30) -- We wait for pickup to be created
	
	local mypos = localplayer:get_position()
	for p in replayinterface.get_pickups() do
		if p:get_amount() == 1337 then
			p:set_amount(2000)
			p:set_pickup_hash(weapon)
			break
		end
	end
end

























































































local VehicleHashName = table_invert(VehicleHash)

local Tsk=1					--On Admin Detection; 1-DoARoundabout, 2-JoinPublic, 3-EmptySession
local ChSs=KeyCode.VK_PRIOR			--ChangeSession Hotkey, nil to disable
local EmSs=KeyCode.VK_PAUSE --Pause|Break key	--EmptySession Hotkey, nil to disable
local enable = false		--ExplodeLoop hotkey default(on/off>true/false)
local TL=KeyCode.VK_NUMPAD9	--TrollLoop hotkey, Numpad9

local SsTy=Global.SessionType	--v1.61 Session Type
local SsTr=Global.SessionTrigger	--v1.61 Session Trigger
local CrVh=Global.CreateVehicle	--Create Vehicle Offset
	
-- On Admin Detection
local nme=0

local function ChangeSession()
	globals.set_int(SsTy, 0)
	globals.set_int(SsTr, 1)
	sleep(0.01)
	globals.set_int(SsTr, 0)
	nme=0
end

local function ondetect()
	if Tsk==2 then ChangeSession()
	elseif Tsk==3 then EmptySession()
	else if nme~=adm then nme=adm
	menu.send_key_press(157)
end end end

if Hkey1 then menu.remove_hotkey(Hkey1) end
if ChSs then Hkey1=menu.register_hotkey(ChSs, ChangeSession) end
local function EmptySession()
	--menu.empty_session()--]] nme=0
end
if Hkey2 then menu.remove_hotkey(Hkey1) end
if EmSs then Hkey2=menu.register_hotkey(EmSs, EmptySession) end

-- Function definitions
local function null() end
local function Text(submenu, text)
	if (submenu ~= nil) then
		submenu:add_action(text, null)
	else
		menu.add_action(text, null)
	end
end
-- Action functions
local function TeleportToPlayer(ply, seconds)
	if not ply or ply == nil then return end 
	local pos = ply:get_position()
	if seconds then
		if localplayer:is_in_vehicle() then
			--print("can not teleport while in vehicle")
			return
		end
 
		local oldpos = localplayer:get_position()
		localplayer:set_position(pos)
		sleep(seconds)
		localplayer:set_freeze_momentum(true) 
		localplayer:set_config_flag(292,true)
		localplayer:set_position(oldpos)
		localplayer:set_freeze_momentum(false) 
		localplayer:set_config_flag(292,false)
		return
	end
	if not localplayer:is_in_vehicle() then
		localplayer:set_position(pos)
	else
		localplayer:get_current_vehicle():set_position(pos)
	end
	sleep(0.1)
	if not localplayer:is_in_vehicle() then
		localplayer:set_position(pos)
	else
		localplayer:get_current_vehicle():set_position(pos)
	end
	local pos = ply:get_position()
	sleep(0.1)
	if not localplayer:is_in_vehicle() then
		localplayer:set_position(pos)
	else
		localplayer:get_current_vehicle():set_position(pos)
	end
	sleep(0.1)
	if not localplayer:is_in_vehicle() then
		localplayer:set_position(pos)
	else
		localplayer:get_current_vehicle():set_position(pos)
	end
	sleep(0.1)
	if not localplayer:is_in_vehicle() then
		localplayer:set_position(pos)
	else
		localplayer:get_current_vehicle():set_position(pos)
	end
end
local function TeleportClosestVehicleToPlayer(ply)
	if not ply or ply == nil then return end
	pos2=ply:get_position()
	sleep(0.1)
	pos1=ply:get_position()
	disX=(pos1.x-pos2.x) disY=(pos1.y-pos2.y) disZ=(pos1.z-pos2.z)
	local veh = localplayer:get_nearest_vehicle()
	if not veh or localplayer:get_nearest_vehicle()==localplayer:get_current_vehicle() then return end
	veh:set_position(ply:get_position()+vector3(2*disX, 2*disY, disZ))
end
local function TeleportPedsToPlayer(ply, dead)
	if not ply or ply == nil then return end
	pos2=ply:get_position()
	sleep(0.1)
	pos1=ply:get_position()
	disX=(pos1.x-pos2.x) disY=(pos1.y-pos2.y) disZ=(pos1.z-pos2.z)
	for ped in replayinterface.get_peds() do
		if player_is_npc(ped) then
			if not ped:is_in_vehicle() then
				ped:set_position(ply:get_position()+vector3(2*disX, 2*disY, disZ))
			end
		end
	end
end
local function ExplodePlayer(ply)
	if not ply or ply == nil then return end
	pos2=ply:get_position()
	sleep(0.1)
	pos1=ply:get_position()
	disX=(pos1.x-pos2.x) disY=(pos1.y-pos2.y) disZ=(pos1.z-pos2.z)
	local currentvehicle = nil 
	if localplayer:is_in_vehicle() then
		currentvehicle = localplayer:get_current_vehicle()
	end
	for veh in replayinterface.get_vehicles() do
		if not currentvehicle or currentvehicle ~= veh then
		if not player_get_vehicle(veh) then
			acc=veh:get_acceleration()
			veh:set_acceleration(0)
			veh:set_rotation(vector3(0,0,180))
			veh:set_health(-1)
			veh:set_position(ply:get_position()+vector3(disX, disY, disZ))
			veh:set_acceleration(acc)
		end
		end
	end
end
local function LaunchPlayer(ply)
	if not ply or ply == nil then return end
	pos2=ply:get_position()
	sleep(0.1)
	pos1=ply:get_position()
	disX=(pos1.x-pos2.x) disY=(pos1.y-pos2.y) disZ=(pos1.z-pos2.z)
	local currentvehicle = nil 
	if localplayer:is_in_vehicle() then
		currentvehicle = localplayer:get_current_vehicle()
	end
	local i = 0
	for veh in replayinterface.get_vehicles() do
		if not currentvehicle or currentvehicle ~= veh then
		if not player_get_vehicle(veh) then
			acc=veh:get_acceleration()
			veh:set_acceleration(0)
			veh:set_rotation(vector3(0,0,0))
			veh:set_gravity(-100)
			veh:set_position(ply:get_position()+vector3(2.5*disX, 2.5*disY, disZ-5))
			veh:set_acceleration(acc)
		end
		end
	end
	sleep(1)
	for veh in replayinterface.get_vehicles() do
		if not currentvehicle or currentvehicle ~= veh then
			veh:set_gravity(9.8)
		end
	end
end
local function SlamPlayer(ply)
	if not ply or ply == nil then return end
	pos2=ply:get_position()
	sleep(0.1)
	pos1=ply:get_position()
	disX=(pos1.x-pos2.x) disY=(pos1.y-pos2.y) disZ=(pos1.z-pos2.z)
	local currentvehicle = nil 
	if localplayer:is_in_vehicle() then
		currentvehicle = localplayer:get_current_vehicle()
	end
	local i = 0
	for veh in replayinterface.get_vehicles() do
		if not currentvehicle or currentvehicle ~= veh then
		if not player_get_vehicle(veh) then
			acc=veh:get_acceleration()
			veh:set_acceleration(0)
			veh:set_rotation(vector3(0,0,0))
			veh:set_gravity(10000)
			veh:set_position(ply:get_position()+vector3(5*disX, 5*disY, disZ + 100))
			veh:set_acceleration(acc)
		end
		end
	end
	sleep(1)
	for veh in replayinterface.get_vehicles() do
		if not currentvehicle or currentvehicle ~= veh then
		if not ply:get_current_vehicle() or ply:get_current_vehicle() ~= veh then
			veh:set_gravity(9.8)
		end
		end
	end
end

-- Player option 
local selectedplayer = -1
 
local function f_p_o(ply_id, ply, ply_name) -- Format Player Option Text
	-- log("z_player_actions.lua > f_p_o > ply_id: "..tostring(ply_id).." | ply: "..tostring(ply).." | ply_name: "..tostring(ply_name))
	if ply_id == nil or ply == nil then return end
	local text = ""
	-- if ply == localplayer then
		-- text = text.."YOU"
	-- else
		text = text..""..dump(ply_name)..""
	-- end
	if player_is_modder(ply) then
		text = text.." *"
	end
	text = text.." ("..tostring(ply_id)..")"
	-- Is In GodMode, if not then Player Health & Armor
	if ply:get_godmode() then
		text = text.." | GOD"
	else
		text = text.." |"..string.format("%3.0f",(ply:get_health()/ply:get_max_health())*100).."%"--" / "..string.format("%2.0f",ply:get_armour()*2).."%"
	end

	if ply:is_in_vehicle() then
		local veh = ply:get_current_vehicle()
		if veh ~= nil then
			local veh_hash = veh:get_model_hash()
			if veh_hash ~= nil then
				local veh_name = VehicleHashName[veh_hash]
				if veh_name ~= nil then
					text = text.." | "..veh_name
				else
					text = text.." | 🚗"
				end
			else
				text = text.." | 🚗"
			end
			if veh:get_godmode() then
				text = text.."*"
			end
		else
			text = text.." | 🚗"
		end
	else 
		text = text.." | 🚶"
	end
	local wanted_level = ply:get_wanted_level()
	-- Player Wanted Level
	if wanted_level > 0 then text = text.." | "..wanted_level.."✰" end

	-- Player's Distance From You
	local mypos = localplayer:get_position()
	local plypos = ply:get_position()
	local distance = math.floor(math_distance2(plypos, mypos))
	-- print(text.." mypos: "..tostring(mypos) .. " ||| plypos: " .. tostring(plypos))
	if distance > 0 then text = text.." | "..distance.."m" end
	
	return text
end
 
local function add_player_option(submenu, ply_id, ply, ply_name)
	-- log("z_player_actions.lua > add_player_option > ply_id: "..dump(ply_id).." | ply: "..dump(ply).." | ply_name: "..dump(ply_name))
	local text = f_p_o(ply_id, ply, ply_name)
	if text == nil then return end
	local d = ply_id
 
	if (submenu ~= nil) then
		submenu:add_bare_item(text, function() return f_p_o(ply_id, ply, ply_name).."|"..(selectedplayer == ply_id and "✓" or "□")  end, function() selectedplayer = d end, null, null)
	else
		menu.add_bare_item(text, function() return f_p_o(ply_id, ply, ply_name).."|"..(selectedplayer == ply_id and "✓" or "□") end, function() selectedplayer = d end, null, null)
	end
end
 
local function add_info_option(submenu, text, funcget, forceplayer)
	local func = function() 
		local ply = player.get_player_ped(forceplayer and forceplayer or selectedplayer)
		if not ply then return text..": **Invalid**" end
		return text..": "..funcget(ply)
	end
	if (submenu ~= nil) then
		submenu:add_bare_item(text..": ", func, null, null, null)
	else
		menu.add_bare_item(text..": ", func, null, null, null)
	end
end

-- TrollLoop
local mpx = stats.get_int("MPPLY_LAST_MP_CHAR")
local function switch()
	if selectedplayer==nil then return end
	if stats.get_int("MP"..mpx.."_H4LOOT_WEED_I_SCOPED") == 0 then
		stats.set_int("MP"..mpx.."_H4LOOT_WEED_I_SCOPED", 8192)
		globals.set_int(CrVh+27+6, selectedplayer)
		sleep(1.0)
		menu.send_key_press(155)
	else
		stats.set_int("MP"..mpx.."_H4LOOT_WEED_I_SCOPED", 0)
	end
end
if Exploop then menu.remove_hotkey(Exploop) end
local Exploop=nil
if enable then
	Exploop = menu.register_hotkey(TL, switch)
end
local function LooP(e)
	if e then
		Exploop = menu.register_hotkey(TL, switch)
	else
		menu.remove_hotkey(Exploop)
		stats.set_int("MP"..mpx.."_H4LOOT_WEED_I_SCOPED", 0)
		globals.set_int(CrVh+27+6, 0)
	end
end
-- menu.add_toggle("TrollLoop(NUM9)", function()
-- 	return enable
-- end, function()
-- 	enable = not enable 
-- 	LooP(enable)
-- end)

-- Building Player List
local playerlist = menu.add_submenu("--- PLAYER LIST --- | "..player.get_number_of_players())
local adm=""
local function BuildListOld()

 	playerlist:add_bare_item("--- "..player.get_number_of_players().." Players --- Tap this to reload", null,function() playerlist:clear() BuildListOld() end, null, null)
 
	local players = {}

	-- WITHOUT DISTANCE --- 
	for i = 0, 31 do
		local ply = player.get_player_ped(i)
		if ply then players[i] = {ply, player.get_player_name(i)} end
	end
	-- table.sort(players, function(a,b) return a[2] < b[2] end)
	-- print(table_dump(players))
	for id, player in pairs(players) do
		add_player_option(playerlist, id, player[1], player[2])
		for x=1, #RockstarStaff do
			if player[2]==RockstarStaff[x] then
				adm="[ Admin>"..admin.." ]"
				ondetect()
			end
		end
	end
	-- WITHOUT DISTANCE --- 
	-- --- WITH DISTANCE	 
	-- local PlayersDistances = {}
	-- local SortedPlayers = {}
	-- local _i = 0
	-- local mypos = localplayer:get_position()
	-- print("mypos: "..tostring(mypos))
	-- for i = 0, 31 do
	-- 	local ply = player.get_player_ped(i)
	-- 	if ply then 
	-- 		local plypos = ply:get_position()
	-- 		print("plypos ".._i.." is at "..tostring(plypos))
	-- 		PlayersDistances[_i] = {ply, math_distance2(plypos, mypos)}
	-- 		_i = _i + 1
	-- 	end
	-- end
	-- log("z_player_actions.lua > PlayersDistances: "..dump(PlayersDistances))
	-- if _i == nil then return end
	-- for c = 1, _i do
	-- 	log("z_player_actions.lua > (for c = 1, _i do) c: " ..dump(c).." | _i: "..dump(_i))
	-- 	local smallest = {nil, nil}
	-- 	for plyd = 1, #PlayersDistances do
	-- 		log("z_player_actions.lua > (for plyd = 1, #PlayersDistances do) c: " ..dump(plyd))
	-- 		if not array_contains(SortedPlayers, PlayersDistances[plyd][1]) then 
	-- 			if smallest[2] == nil or PlayersDistances[plyd][2] <= smallest[2] then
	-- 				smallest = PlayersDistances[plyd]
	-- 			end
	-- 		end
	-- 	end
	-- 	SortedPlayers[c] = smallest[1]
	-- end
	-- log("z_player_actions.lua > SortedPlayers: "..dump(SortedPlayers))
	-- for ply = 0, #SortedPlayers do
	-- 	-- log("z_player_actions.lua > (for ply = 0, #SortedPlayers do) ply: " ..dump(ply).." | SortedPlayers[ply]: "..dump(nil))
	-- 	add_player_option(playerlist, ply, SortedPlayers[ply], player.get_player_name(ply))
	-- 	admin=player.get_player_name(ply)
	-- 	for x=1, #RockstarStaff do
	-- 		if admin==RockstarStaff[x] then
	-- 			adm="[ Admin>"..admin.." ]"
	-- 			ondetect()
	-- 		end
	-- 	end
	-- end
	-- --- WITH DISTANCE
	--log("z_player_actions.lua > added players")
	-- test

	Text(playerlist, "    ---End---"..adm)
	
	local title = "On Admin Detection>"
	local actionss = {"Do a roundabout", "Change Session", "Empty Session"}
	local function set_title()
		return  title .. " | < " ..  actionss[Tsk] .. " >"
	end	
   local function next_item()
		if Tsk < #actionss then Tsk = Tsk + 1 end
        return set_title()
    end
    local function previous_item()
		if Tsk > 1 then Tsk = Tsk - 1 end
        return set_title()
    end
	playerlist:add_bare_item(title, set_title, function() return actionss[Tsk] end, previous_item, next_item)



	--playerlist:add_array_item("On Admin Detection>", {"Do a roundabout", "Change Session", "Empty Session"}, function() return Tsk end, function(d) Tsk=d --[[ondetect()--]] end)
 	
	
	add_info_option(playerlist, "Selected Player>", function() return player.get_player_name(selectedplayer) end)
	
	-- Troll Options
	local LTr
	local function LTro()
		if LTr == nil then
			return 1
		else
			return LTr
		end
	end
	local TrOp = {}
	TrOp[1] = "Explosion"
	TrOp[2] = "Anti-Gravity"
	TrOp[3] = "Slamming"
	playerlist:add_array_item("Troll by>", TrOp, function() return LTro() end, function(Trll)
		LTr=Trll
		if Trll == 1 then
			ExplodePlayer(player.get_player_ped(selectedplayer))
		elseif Trll == 2 then
			LaunchPlayer(player.get_player_ped(selectedplayer))
		else
			SlamPlayer(player.get_player_ped(selectedplayer))
		end
	end)
	
	--Teleport Options
	playerlist:add_int_range("Peek for(seconds)", 2, 1, 10, function() return 2 end, function(n) TeleportToPlayer(player.get_player_ped(selectedplayer), n) end)
	
	local LGf
	local function LsGft()
		if LGf == nil then
			return 2
		else
			return LGf
		end
	end
	local OlPos
	local Used
 	local TPOp = {}
	TPOp[1] = "Yourself"
	TPOp[2] = "Closest Vehicle"
	TPOp[3] = "Peds"
	playerlist:add_array_item("Send to player>", TPOp, function() return LsGft() end, function(LsTP)
		LGf=LsTP
		if LsTP == 1 then
			if Used==1 or Used==nil then
				OlPos=localplayer:get_position()
				Used=0
			end
			TeleportToPlayer(player.get_player_ped(selectedplayer))
		elseif LsTP == 2 then
			TeleportClosestVehicleToPlayer(player.get_player_ped(selectedplayer))
		elseif LsTP == 3 then 
			TeleportPedsToPlayer(player.get_player_ped(selectedplayer))
		end
	end)
	playerlist:add_action("Teleport back", function()
		if OlPos~=nil then
			if not localplayer:is_in_vehicle() then
				localplayer:set_position(OlPos)
			else
				localplayer:get_current_vehicle():set_position(Olpos)
			end
			if localplayer:get_position()==OlPos then
				Used=1
			end
		end
	end)

 
    local moreinfo=playerlist:add_submenu("More info on player")
	local function ply() return player.get_player_ped(selectedplayer) end
	local TR={} TR[1]="Yes" TR[0]="No"
	moreinfo:add_float_range("MaxHealth", 0, 0, 0, function()
		if ply() then return ply():get_max_health() end end, function() end)
	moreinfo:add_float_range("Health", 0, 0, 0, function()
		if ply() then return ply():get_health() end end, function() end)
	moreinfo:add_float_range("Armour", 0, 0, 0, function()
		if ply() then return ply():get_armour() end end, function() end)
	moreinfo:add_float_range("Run Speed", 0, 0, 0, function()
		if ply() then return ply():get_run_speed() end end, function() end)
	moreinfo:add_float_range("Swim Speed", 0, 0, 0, function()
		if ply() then return ply():get_swim_speed() end end, function() end)
	moreinfo:add_int_range("Wanted level", 0, 0, 0, function()
		if ply() then return ply():get_wanted_level() end end, function() end)
	moreinfo:add_array_item("Can be targeted>", TR, function()
		if ply() and ply():get_can_be_targeted() then return 1 else return 0 end end, function() end)
	moreinfo:add_array_item("No ragdoll>", TR, function()
		if ply() and ply():get_no_ragdoll() then return 1 else return 0 end end, function() end)
		
	moreinfo:add_action("            Vehicle Info(close range only)", function() end)
	moreinfo:add_array_item("Seatbelt>", TR, function()
		if ply() and ply():get_seatbelt() then return 1 else return 0 end end, function() end)
	moreinfo:add_float_range("Gravity", 0, 0, 0, function()
		if ply() and ply():is_in_vehicle() then return ply():get_current_vehicle():get_gravity() end end, function() end)
	moreinfo:add_float_range("Accelaration", 0, 0, 0, function()
		if ply() and ply():is_in_vehicle() then return ply():get_current_vehicle():get_acceleration() end end, function() end)
	moreinfo:add_float_range("Max Speed", 0, 0, 0, function()
		if ply() and ply():is_in_vehicle() then return ply():get_current_vehicle():get_max_speed() end end, function() end)
	moreinfo:add_float_range("Mass", 0, 0, 0, function()
		if ply() and ply():is_in_vehicle() then return ply():get_current_vehicle():get_mass() end end, function() end)
	moreinfo:add_int_range("Bomb Count>", 0, 0, 0, function()
		if ply() and ply():is_in_vehicle() then return ply():get_current_vehicle():get_bomb_count() end end, function() end)
	moreinfo:add_int_range("CounterMeasure Count>", 0, 0, 0, function()
		if ply() and ply():is_in_vehicle() then return ply():get_current_vehicle():get_countermeasure_count() end end, function() end)
	moreinfo:add_float_range("Boost amount>", 0, 0, 0, function()
		if ply() and ply():is_in_vehicle() then return ply():get_current_vehicle():get_boost() end end, function() end)
	moreinfo:add_array_item("Boost is active>", TR, function()
		if ply() and ply():is_in_vehicle() then if ply():get_current_vehicle():get_boost_active() then return 1 else return 0 end end end, function() end)
	moreinfo:add_array_item("Can be targeted>", TR, function()
		if ply() and ply():is_in_vehicle() then if ply():get_current_vehicle():get_can_be_targeted() then return 1 else return 0 end end end, function() end)
	moreinfo:add_array_item("Visible Damage>", TR, function()
		if ply() and ply():is_in_vehicle() then if ply():get_current_vehicle():get_can_be_visibly_damaged() then return 1 else return 0 end end end, function() end)
	moreinfo:add_array_item("Window Damage>", TR, function()
		if ply() and ply():is_in_vehicle() then if ply():get_current_vehicle():get_window_collisions_disabled() then return 0 else return 1 end end end, function() end)
		
	moreinfo:add_action("                     Weapon Info", function() end)
		
	moreinfo:add_array_item("Infinite Ammo>", TR, function()
		if ply() and ply():get_infinite_ammo() then return 1 else return 0 end end, function() end)
	moreinfo:add_array_item("Infinite Clip>", TR, function()
		if ply() and ply():get_infinite_clip() then return 1 else return 0 end end, function() end)
	moreinfo:add_int_range("Current Ammo", 0, 0, 0, function()
		if ply() and ply():get_current_weapon() then return ply():get_current_weapon():get_current_ammo() end end, function() end)
	moreinfo:add_float_range("Reload time multiplier", 0, 0, 0, function()
		if ply() and ply():get_current_weapon() then return ply():get_current_weapon():get_reload_time_multiplier() end end, function() end)
	moreinfo:add_float_range("Time between shots", 0, 0, 0, function()
		if ply() and ply():get_current_weapon() then return ply():get_current_weapon():get_time_between_shots() end end, function() end)
	moreinfo:add_float_range("Range", 0, 0, 0, function()
		if ply() and ply():get_current_weapon() then return ply():get_current_weapon():get_range() end end, function() end)
	moreinfo:add_float_range("Lock-On range", 0, 0, 0, function()
		if ply() and ply():get_current_weapon() then return ply():get_current_weapon():get_lock_on_range() end end, function() end)
	moreinfo:add_float_range("Ped Hit Force", 0, 0, 0, function()
		if ply() and ply():get_current_weapon() then return ply():get_current_weapon():get_ped_force() end end, function() end)
	moreinfo:add_float_range("Vehicle Hit Force", 0, 0, 0, function()
		if ply() and ply():get_current_weapon() then return ply():get_current_weapon():get_vehicle_force() end end, function() end)
	moreinfo:add_float_range("Heli Hit Force", 0, 0, 0, function()
		if ply() and ply():get_current_weapon() then return ply():get_current_weapon():get_heli_force() end end, function() end)
	moreinfo:add_int_range("Fire Type", 0, 0, 0, function()
		if ply() and ply():get_current_weapon() then return ply():get_current_weapon():get_fire_type() end end, function() end)
	moreinfo:add_int_range("Explosion Type", 0, 0, 0, function()
		if ply() and ply():get_current_weapon() then return ply():get_current_weapon():get_explosion_type() end end, function() end)
	moreinfo:add_int_range("Damage Type", 0, 0, 0, function()
		if ply() and ply():get_current_weapon() then return ply():get_current_weapon():get_damage_type() end end, function() end)


    local playerflags=playerlist:add_submenu("Player Flags")
	local function ply() return player.get_player_ped(selectedplayer) end
	local function hasConfigFlag(flag)
		_player = ply()
		if _player == nil or flag == nil then return false end
		return _player:get_config_flag(flag)
	end
	local function setConfigFlag(flag, v)
		_player = ply()
		if _player ~= nil and flag ~= nil then _player:set_config_flag(flag, v) end
	end
	local function add_flag_toggle(name, flag)
		if name == nil or flag == nil then return end
		playerflags:add_toggle(name, function() return hasConfigFlag(flag) end, function(v) setConfigFlag(flag, v) end)
	end
	for key, value in pairs(PedConfigFlag) do
		add_flag_toggle(""..key, value)
	end

    local moreinfo=playerlist:add_submenu("More info on player")
	local function ply() return player.get_player_ped(selectedplayer) end
	local TR={} TR[1]="Yes" TR[0]="No"
	moreinfo:add_float_range("MaxHealth", 0, 0, 0, function()
		if ply() then return ply():get_max_health() end end, function() end)
	moreinfo:add_float_range("Health", 0, 0, 0, function()
		if ply() then return ply():get_health() end end, function() end)
	moreinfo:add_float_range("Armour", 0, 0, 0, function()
		if ply() then return ply():get_armour() end end, function() end)
	moreinfo:add_float_range("Run Speed", 0, 0, 0, function()
		if ply() then return ply():get_run_speed() end end, function() end)
	moreinfo:add_float_range("Swim Speed", 0, 0, 0, function()
		if ply() then return ply():get_swim_speed() end end, function() end)
	moreinfo:add_int_range("Wanted level", 0, 0, 0, function()
		if ply() then return ply():get_wanted_level() end end, function() end)
	moreinfo:add_array_item("Can be targeted>", TR, function()
		if ply() and ply():get_can_be_targeted() then return 1 else return 0 end end, function() end)
	moreinfo:add_array_item("No ragdoll>", TR, function()
		if ply() and ply():get_no_ragdoll() then return 1 else return 0 end end, function() end)
		
	moreinfo:add_action("            Vehicle Info(close range only)", function() end)
	moreinfo:add_toggle("Seatbelt>", function() return ply() and ply():get_seatbelt() end, function() end)
	moreinfo:add_float_range("Gravity", 0, 0, 0, function()
		if ply() and ply():is_in_vehicle() then return ply():get_current_vehicle():get_gravity() end end, function() end)
	moreinfo:add_float_range("Accelaration", 0, 0, 0, function()
		if ply() and ply():is_in_vehicle() then return ply():get_current_vehicle():get_acceleration() end end, function() end)
	moreinfo:add_float_range("Max Speed", 0, 0, 0, function()
		if ply() and ply():is_in_vehicle() then return ply():get_current_vehicle():get_max_speed() end end, function() end)
	moreinfo:add_float_range("Mass", 0, 0, 0, function()
		if ply() and ply():is_in_vehicle() then return ply():get_current_vehicle():get_mass() end end, function() end)
	moreinfo:add_int_range("Bomb Count>", 0, 0, 0, function()
		if ply() and ply():is_in_vehicle() then return ply():get_current_vehicle():get_bomb_count() end end, function() end)
	moreinfo:add_int_range("CounterMeasure Count>", 0, 0, 0, function()
		if ply() and ply():is_in_vehicle() then return ply():get_current_vehicle():get_countermeasure_count() end end, function() end)
	moreinfo:add_float_range("Boost amount>", 0, 0, 0, function()
		if ply() and ply():is_in_vehicle() then return ply():get_current_vehicle():get_boost() end end, function() end)
	moreinfo:add_array_item("Boost is active>", TR, function()
		if ply() and ply():is_in_vehicle() then if ply():get_current_vehicle():get_boost_active() then return 1 else return 0 end end end, function() end)
	moreinfo:add_array_item("Can be targeted>", TR, function()
		if ply() and ply():is_in_vehicle() then if ply():get_current_vehicle():get_can_be_targeted() then return 1 else return 0 end end end, function() end)
	moreinfo:add_array_item("Visible Damage>", TR, function()
		if ply() and ply():is_in_vehicle() then if ply():get_current_vehicle():get_can_be_visibly_damaged() then return 1 else return 0 end end end, function() end)
	moreinfo:add_array_item("Window Damage>", TR, function()
		if ply() and ply():is_in_vehicle() then if ply():get_current_vehicle():get_window_collisions_disabled() then return 0 else return 1 end end end, function() end)
		
	moreinfo:add_action("                     Weapon Info", function() end)
		
	moreinfo:add_array_item("Infinite Ammo>", TR, function()
		if ply() and ply():get_infinite_ammo() then return 1 else return 0 end end, function() end)
	moreinfo:add_array_item("Infinite Clip>", TR, function()
		if ply() and ply():get_infinite_clip() then return 1 else return 0 end end, function() end)
	moreinfo:add_int_range("Current Ammo", 0, 0, 0, function()
		if ply() and ply():get_current_weapon() then return ply():get_current_weapon():get_current_ammo() end end, function() end)
	moreinfo:add_float_range("Reload time multiplier", 0, 0, 0, function()
		if ply() and ply():get_current_weapon() then return ply():get_current_weapon():get_reload_time_multiplier() end end, function() end)
	moreinfo:add_float_range("Time between shots", 0, 0, 0, function()
		if ply() and ply():get_current_weapon() then return ply():get_current_weapon():get_time_between_shots() end end, function() end)
	moreinfo:add_float_range("Range", 0, 0, 0, function()
		if ply() and ply():get_current_weapon() then return ply():get_current_weapon():get_range() end end, function() end)
	moreinfo:add_float_range("Lock-On range", 0, 0, 0, function()
		if ply() and ply():get_current_weapon() then return ply():get_current_weapon():get_lock_on_range() end end, function() end)
	moreinfo:add_float_range("Ped Hit Force", 0, 0, 0, function()
		if ply() and ply():get_current_weapon() then return ply():get_current_weapon():get_ped_force() end end, function() end)
	moreinfo:add_float_range("Vehicle Hit Force", 0, 0, 0, function()
		if ply() and ply():get_current_weapon() then return ply():get_current_weapon():get_vehicle_force() end end, function() end)
	moreinfo:add_float_range("Heli Hit Force", 0, 0, 0, function()
		if ply() and ply():get_current_weapon() then return ply():get_current_weapon():get_heli_force() end end, function() end)
	moreinfo:add_int_range("Fire Type", 0, 0, 0, function()
		if ply() and ply():get_current_weapon() then return ply():get_current_weapon():get_fire_type() end end, function() end)
	moreinfo:add_int_range("Explosion Type", 0, 0, 0, function()
		if ply() and ply():get_current_weapon() then return ply():get_current_weapon():get_explosion_type() end end, function() end)
	moreinfo:add_int_range("Damage Type", 0, 0, 0, function()
		if ply() and ply():get_current_weapon() then return ply():get_current_weapon():get_damage_type() end end, function() end)


   local pedactions=playerlist:add_submenu("Ped Actions")
	local function ply() return player.get_player_ped(selectedplayer) end
	if ply() == nil or ply():get_armour() == nil then return end
   pedactions:add_float_range("armour",10,0,500,function() return ply():get_armour() 		    end, function(v) ply():set_armour(v) end)
 	pedactions:add_toggle("can_be_targeted",function() return ply():get_can_be_targeted()   end, function(v) ply():set_can_be_targeted(v) end)
	pedactions:add_toggle("freeze_momentum",function() return ply():get_freeze_momentum()   end, function(v) ply():set_freeze_momentum(v) end)
	pedactions:add_toggle("godmode", 		function() return ply():get_godmode()           end, function(v) ply():set_godmode(v) end)
 pedactions:add_float_range("health",10,0,0,function() return ply():get_health()		    end, function(v) ply():set_health(v) end)
 pedactions:add_float_range("hurt_health",10,0,0,function() return ply():get_hurt_health()end, function(v) ply():set_hurt_health(v) end)
	pedactions:add_toggle("infinite_ammo", 	function() return ply():get_infinite_ammo()     end, function(v) ply():set_infinite_ammo(v) end)
	pedactions:add_toggle("infinite_clip", 	function() return ply():get_infinite_clip()     end, function(v) ply():set_infinite_clip(v) end)
 pedactions:add_float_range("max_health",10,0,0,function() return ply():get_max_health()	end, function(v) ply():set_max_health(v) end)
	pedactions:add_toggle("no_ragdoll", 	function() return ply():get_no_ragdoll()        end, function(v) ply():set_no_ragdoll(v) end)
 -- pedactions.add_bare_item("position", function() return "Position | "..player_position_string(ply()) end,function()end,function()end,function()end)
 -- pedactions:add_toggle("reset_flag", 	function() return ply():get_reset_flag()		end, function(v) ply():set_reset_flag(v) end)
 -- pedactions.add_bare_item("rotation", function() return "Rotation | "..player_rotation_string(ply()) end,function()end,function()end,function()end)
 pedactions:add_float_range("run_speed",.1,0,0,function() return ply():get_run_speed()		end, function(v) ply():set_run_speed(v) end)
 pedactions:add_float_range("swim_speed",.1,0,0,function() return ply():get_swim_speed()	end, function(v) ply():set_swim_speed(v) end)
 pedactions:add_int_range("wallet",1,0,0,function() return ply():get_wallet()	end, function(v) ply():set_wallet(v) end)
 pedactions:add_int_range("wanted_level",1,1,5,function() return ply():get_wanted_level()	end, function(v) ply():set_wanted_level(v) end)
 -- pedactions:add_toggle("weapon_enabled", function() return ply():get_weapon_enabled() end, function(v) ply():set_weapon_enabled(v) end)
 
 
 

end

-- List Updater
menu.add_bare_item("Reload Player List", function() playerlist:clear() BuildListOld() end, null, null, null)

--menu.register_hotkey(151, function()  playerlist:clear() BuildListOld() end) 
local function Trigger()
    if  localplayer ~= nil then
		playerlist:clear() BuildListOld() 
    end
end
local events = { "OnPlayerChanged", "OnVehicleChanged", "OnWeaponChanged" }
for i = 1, #events do
    menu.register_callback(events[i], Trigger)
end
 
--print("=== z_player_actions END ===")