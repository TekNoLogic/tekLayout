
local myname, ns = ...


local function OnLogin()
	WorldFrame:ClearAllPoints()
	WorldFrame:SetPoint("TOPLEFT")
	WorldFrame:SetPoint("BOTTOMRIGHT", 0, 140)
end


ns.RegisterCallback("PLAYER_LOGIN", OnLogin)
