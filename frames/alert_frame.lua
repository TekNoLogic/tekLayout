
local myname, ns = ...


local function OnLogin()
	AlertFrame:SetPoint("BOTTOM", 0, 28)
end


ns.RegisterCallback("PLAYER_LOGIN", OnLogin)
