
local myname, ns = ...


local function OnLogin()
	UIPARENT_MANAGED_FRAME_POSITIONS.ExtraActionBarFrame.xOffset = -255
	UIPARENT_MANAGED_FRAME_POSITIONS.ExtraActionBarFrame.yOffset = 50
	ExtraActionBarFrame.button.style:Hide()
	ExtraActionButton1HotKey:Hide()

	local frame = CreateFrame("Frame", nil, ExtraActionButton1)
	frame:SetScript("OnShow", function()
		ActionButton_ShowOverlayGlow(ExtraActionButton1)
	end)
end


ns.RegisterCallback("PLAYER_LOGIN", OnLogin)
