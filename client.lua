-------------------------------------------
---			TUCSTAD ROLEPLAY			---
---			MADE BY JESSE				---
-------------------------------------------

Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(10) -- [[Usually 1 however the difference between the two is un-noticable.]]
        for theveh in EnumerateVehicles() do -- [[Gets every single vehicle that exists... I think.]]
            if GetEntityHealth(theveh) == 0 then -- [[If the vehicle is destroyed continue.]]
                SetEntityAsMissionEntity(theveh, false, false) -- [[Sets the entity as mission entity for further use.]]
                DeleteEntity(theveh) -- [[Once set as mission entity it will be deleted.]]
            end
		end
    end
end)

local entityEnumerator = {
	__gc = function(enum)
	    if enum.destructor and enum.handle then
		    enum.destructor(enum.handle)
	    end
	    enum.destructor = nil
	    enum.handle = nil
	end
}

local function EnumerateEntities(initFunc, moveFunc, disposeFunc)
	return coroutine.wrap(function()
	    local iter, id = initFunc()
	    if not id or id == 0 then
	        disposeFunc(iter)
		    return
	    end
	  
	    local enum = {handle = iter, destructor = disposeFunc}
	    setmetatable(enum, entityEnumerator)
	  
	    local next = true
	    repeat
		    coroutine.yield(id)
		    next, id = moveFunc(iter)
	    until not next
	  
	    enum.destructor, enum.handle = nil, nil
	    disposeFunc(iter)
	end)
end

function EnumerateVehicles()
    return EnumerateEntities(FindFirstVehicle, FindNextVehicle, EndFindVehicle)
end

function sendForbiddenMessage(message)
	TriggerEvent("chatMessage", "", {0, 0, 0}, "^1" .. message)
end

function _DeleteEntity(entity)
	Citizen.InvokeNative(0xAE3CBE5BF394C9C9, Citizen.PointerValueIntInitialized(entity))
end

weaponblacklist = {
	"WEAPON_MINIGUN",
	"WEAPON_STONE_HATCHET",
	"WEAPON_BATTLEAXE",
	"WEAPON_COMBATPISTOL",
	"WEAPON_APPISTOL",
	"WEAPON_PISTOL50",
	"WEAPON_SNSPISTOL",
	"WEAPON_SNSPISTOL_MK2",
	"WEAPON_HEAVYPISTOL",
	"WEAPON_VINTAGEPISTOL",
	"WEAPON_FLAREGUN",
	"WEAPON_MARKSMANPISTOL",
	"WEAPON_REVOLVER",
	"WEAPON_REVOLVER_MK2",
	"WEAPON_DOUBLEACTION",
	"WEAPON_RAYPISTOL",
	"WEAPON_CERAMICPISTOL",
	"WEAPON_NAVYREVOLVER",
	"WEAPON_SMG",
	"WEAPON_SMG_MK2",
	"WEAPON_PUMPSHOTGUN",
	"WEAPON_PUMPSHOTGUN_MK2",
	"WEAPON_BULLPUPSHOTGUN",
	"WEAPON_MUSKET",
	"WEAPON_DBSHOTGUN",
	"WEAPON_AUTOSHOTGUN",
	"WEAPON_ASSAULTRIFLE",
	"WEAPON_ASSAULTRIFLE_MK2",
	"WEAPON_SPECIALCARBINE",
	"WEAPON_SPECIALCARBINE_MK2",
	"WEAPON_BULLPUPRIFLE",
	"WEAPON_BULLPUPRIFLE_MK2",
	"WEAPON_COMBATRIFLE",
	"WEAPON_MG",
	"WEAPON_GUSENBERG",
	"WEAPON_SNIPERRIFLE",
	"WEAPON_HEAVYSNIPER",
	"WEAPON_HEAVYSNIPER_MK2",
	"WEAPON_RPG",
	"WEAPON_GRENADELAUNCHER",
	"WEAPON_GRENADELAUNCHER_SMOKE",
	"WEAPON_FIREWORK",
	"WEAPON_RAILGUN",
	"WEAPON_HOMINGLAUNCHER",
	"WEAPON_COMPACTLAUNCHER",
	"WEAPON_STICKYBOMB",
	"WEAPON_PROXMINE",
	"WEAPON_PIPEBOMB",
	"WEAPON_FLARE"
}

disableallweapons = false


Citizen.CreateThread(function()
	while true do
		Wait(1)

		playerPed = GetPlayerPed(-1)
		if playerPed then
			nothing, weapon = GetCurrentPedWeapon(playerPed, true)

			if disableallweapons then
				RemoveAllPedWeapons(playerPed, true)
			else
				if isWeaponBlacklisted(weapon) then
					RemoveWeaponFromPed(playerPed, weapon)
					sendForbiddenMessage("U bent niet geautoriseerd om dit wapen te gebruiken!")
				end
			end
		end
	end
end)

function isWeaponBlacklisted(model)
	for _, blacklistedWeapon in pairs(weaponblacklist) do
		if model == GetHashKey(blacklistedWeapon) then
			return true
		end
	end

	return false
end


carblacklist = {
	"SUBMERSIBLE",
	"SUBMERSIBLE2",
	"TUG",
	"CERBERUS",
	"CERBERUS2",
	"CERBERUS3",
	"HAULER2",
	"PHANTOM2",
	"STOCKADE",
	"STOCKADE3",
	"DILETTANTE2",
	"ISSI6",
	"AKULA",
	"ANNIHILATOR",
	"BUZZARD",
	"BUZZARD2",
	"CARGOBOB",
	"CARGOBOB2",
	"CARGOBOB3",
	"CARGOBOB4",
	"FROGGER",
	"FROGGER2",
	"HAVOK",
	"HUNTER",
	"MAVERICK",
	"SAVAGE",
	"SEASPARROW",
	"SKYLIFT",
	"SUPERVOLITO",
	"SUPERVOLITO2",
	"SWIFT",
	"SWIFT2",
	"VALKYRIE",
	"VALKYRIE2",
	"VOLATUS",
	"CUTTER",
	"DUMP",
	"GUARDIAN",
	"RUBBLE",
	"MIXER2",
	"APC",
	"BARRACKS",
	"BARRACKS2",
	"BARRACKS3",
	"BARRAGE",
	"CHERNOBOG",
	"CRUSADER",
	"HALFTRACK",
	"KHANJALI",
	"MINITANK",
	"RHINO",
	"SCARAB2",
	"SCARAB3",
	"THRUSTER",
	"TRAILERSMALL2",
	"DEATHBIKE2",
	"DEATHBIKE3",
	"OPPRESSOR",
	"OPPRESSOR2",
	"RROCKET",
	"SHOTARO",
	"DLOADER",
	"DUNE4",
	"DUNE5",
	"MONSTER",
	"MONSTER3",
	"MONSTER4",
	"MONSTER5",
	"ZHABA",
	"FORMULA",
	"FORMULA2",
	"ALPHAZ1",
	"AVENGER",
	"AVENGER2",
	"BESRA",
	"BLIMP",
	"BLIMP2",
	"BLIMP3",
	"BOMBUSHKA",
	"CARGOPLANE",
	"HYDRA",
	"LAZER",
	"PYRO",
	"ROGUE",
	"STRIKEFORCE",
	"TITAN",
	"TULA",
	"VOLATO1",
	"TANKER",
	"TANKER2",
	"FREIGHT",
	"FREIGHTCAR",
	"FREIGHTCONT1",
	"FREIGHTCONT2",
	"FREIGHTGRAIN",
	"METROTRAIN",
	"TANKERCAR"
}

Citizen.CreateThread(function()
	while true do
		Wait(1)

		playerPed = GetPlayerPed(-1)
		if playerPed then
			checkCar(GetVehiclePedIsIn(playerPed, false))

			x, y, z = table.unpack(GetEntityCoords(playerPed, true))
			for _, blacklistedCar in pairs(carblacklist) do
				checkCar(GetClosestVehicle(x, y, z, 100.0, GetHashKey(blacklistedCar), 70))
			end
		end
	end
end)

function checkCar(car)
	if car then
		carModel = GetEntityModel(car)
		carName = GetDisplayNameFromVehicleModel(carModel)

		if isCarBlacklisted(carModel) then
			_DeleteEntity(car)
			sendForbiddenMessage("U bent niet geautoriseerd om dit voertuig te gebruiken!")
		end
	end
end

function isCarBlacklisted(model)
	for _, blacklistedCar in pairs(carblacklist) do
		if model == GetHashKey(blacklistedCar) then
			return true
		end
	end

	return false
end