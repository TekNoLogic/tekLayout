
local myname, ns = ...


local SCALE = .859999995470047 -- max scale: .87


local function OnLogin()
  -- Make sure autoloot is on
	SetCVar("autoLootDefault", 1)


	-- Seems Wrath likes to undo scale from time to time
	SetCVar("useUiScale", 1)
	SetCVar("UISCALE", SCALE)
end


ns.RegisterCallback("PLAYER_LOGIN", OnLogin)
