
local myname, ns = ...


local function OnLogin()
	PetBattleFrame:SetPoint("BOTTOMRIGHT", WorldFrame, "BOTTOMRIGHT", 0, 4)
	PetBattleFrame:SetFrameStrata("HIGH")
end


ns.RegisterCallback("PLAYER_LOGIN", OnLogin)
