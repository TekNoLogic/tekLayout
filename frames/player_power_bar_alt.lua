
local myname, ns = ...


local function OnLogin()
	UIPARENT_ALTERNATE_FRAME_POSITIONS.PlayerPowerBarAlt_Bottom.yOffset = 50
end


ns.RegisterCallback("PLAYER_LOGIN", OnLogin)
