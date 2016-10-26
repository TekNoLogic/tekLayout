
local myname, ns = ...


local SCALE = .859999995470047 -- max scale: .87


local function OnLogin()
	-- Make sure autoloot is on
	SetCVar("autoLootDefault", 1)


	-- Seems Wrath likes to undo scale from time to time
	SetCVar("useUiScale", 1)
	SetCVar("UISCALE", SCALE)


	WorldFrame:ClearAllPoints()
	WorldFrame:SetPoint("TOPLEFT")
	WorldFrame:SetPoint("BOTTOMRIGHT", 0, 140)

	PetBattleFrame:SetPoint("BOTTOMRIGHT", WorldFrame, "BOTTOMRIGHT", 0, 4)
	PetBattleFrame:SetFrameStrata("HIGH")

	AlertFrame:SetPoint("BOTTOM", 0, 28)

	UIPARENT_MANAGED_FRAME_POSITIONS.ExtraActionBarFrame.xOffset = -255
	UIPARENT_MANAGED_FRAME_POSITIONS.ExtraActionBarFrame.yOffset = 50
	ExtraActionBarFrame.button.style:Hide()
	ExtraActionButton1HotKey:Hide()

	local frame = CreateFrame("Frame", nil, ExtraActionButton1)
	frame:SetScript("OnShow", function()
		ActionButton_ShowOverlayGlow(ExtraActionButton1)
	end)

	UIPARENT_ALTERNATE_FRAME_POSITIONS.PlayerPowerBarAlt_Bottom.yOffset = 50

	UIPARENT_MANAGED_FRAME_POSITIONS.ArcheologyDigsiteProgressBar.yOffset = 60
end


ns.RegisterCallback(myname, "PLAYER_LOGIN", OnLogin)
