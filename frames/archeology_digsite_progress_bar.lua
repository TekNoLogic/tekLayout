
local myname, ns = ...


local function OnLogin()
	UIPARENT_MANAGED_FRAME_POSITIONS.ArcheologyDigsiteProgressBar.yOffset = 60
end


ns.RegisterCallback("PLAYER_LOGIN", OnLogin)
