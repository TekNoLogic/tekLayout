
local SCALE, VSIZE, GAP = .859999995470047, 150, 6 -- max scale: .87


local groups = {
	[ChatFrame1] = {"BN_INLINE_TOAST_ALERT", "SYSTEM", "SYSTEM_NOMENU", "SAY", "EMOTE", "MONSTER_SAY", "MONSTER_YELL", "MONSTER_EMOTE", "MONSTER_WHISPER", "MONSTER_BOSS_EMOTE", "MONSTER_BOSS_WHISPER", "ERRORS", "CHANNEL", "ACHIEVEMENT"},
	[ChatFrame3] = {"GUILD", "GUILD_OFFICER", "GUILD_ACHIEVEMENT"},
	[ChatFrame4] = {"BN_WHISPER", "BN_CONVERSATION", "WHISPER", "AFK", "DND", "IGNORED", "PARTY", "PARTY_LEADER", "RAID", "RAID_LEADER", "BG_HORDE", "BG_ALLIANCE", "BG_NEUTRAL", "BATTLEGROUND", "BATTLEGROUND_LEADER", "RAID_WARNING"},
	[ChatFrame6] = {"COMBAT_FACTION_CHANGE", "SKILL", "LOOT", "MONEY", "COMBAT_XP_GAIN", "COMBAT_HONOR_GAIN", "COMBAT_MISC_INFO"},
}


local function SetupFrame(frame, h, w, r, g, b, a, ...)
	local id = frame:GetID()

	if frame ~= ChatFrame1 then
		SetChatWindowDocked(id, nil)
		for i,v in pairs(DOCKED_CHAT_FRAMES) do if v == frame then table.remove(DOCKED_CHAT_FRAMES, i) end end
		frame.isDocked = nil

		frame.isLocked = nil
		SetChatWindowLocked(id, nil)
	end

	frame:ClearAllPoints()
	frame:SetPoint(...)
	frame:SetHeight(h)
	frame:SetWidth(w)
	frame:Show()

	FCF_SetWindowColor(frame, r/255, g/255, b/255)
	FCF_SetWindowAlpha(frame, a/255)

	local font, _, flags = frame:GetFont()
	frame:SetFont(font, 11, flags)
	SetChatWindowSize(id, 11)

--~ 	ChatFrame_RemoveAllChannels(frame)
--~ 	frame.channelList = {}
--~ 	frame.zoneChannelList = {};
	ChatFrame_RemoveChannel(frame, "General")
	ChatFrame_RemoveAllMessageGroups(frame)
	for i,v in pairs(groups[frame]) do ChatFrame_AddMessageGroup(frame, v) end
end

--~ local f = CreateFrame("Frame")
--~ f:RegisterEvent("UPDATE_CHAT_WINDOWS")
--~ f:SetScript("OnEvent", function()
--~ 	f:UnregisterAllEvents()
--~ 	print("HAI!")
--~ 	ChatFrame3.channelList[1], ChatFrame3.zoneChannelList[1] = "GuildRecruitment", 25
--~ 	ChatFrame_RegisterForChannels(ChatFrame3, "GuildRecruitment", 25)
--~ 	ChatFrame_AddChannel(ChatFrame3, "GuildRecruitment")
--~ 	ChatFrame_AddChannel(ChatFrame3, "Trade")
--~ end)

local f = CreateFrame("frame")
f:RegisterEvent("PLAYER_LOGIN")
f:SetScript("OnEvent", function()
	f:UnregisterAllEvents()
	f:SetScript("OnEvent", nil)


	-- Make sure autoloot is on
	SetCVar("autoLootDefault", 1)


	-- Seems Wrath likes to undo scale from time to time
	SetCVar("useUiScale", 1)
	SetCVar("UISCALE", SCALE)

	local HSIZE = UIParent:GetWidth()/3-GAP


	-- Force on raid coloring
	for i,v in pairs(CHAT_CONFIG_CHAT_LEFT) do ToggleChatColorNamesByClassGroup(true, v.type) end


	SetupFrame(ChatFrame1, VSIZE, HSIZE, 51, 51, 51, 107, "BOTTOMLEFT", UIParent, GAP/2, GAP+3)
	ChatFrame1.SetPoint = function() end -- Wrath build 8820 started resetting ChatFrame1's position.  This ensures it doesn't fuck with my layout.
	SetupFrame(ChatFrame3, VSIZE/2 - GAP/2, HSIZE, 5, 70, 6, 91, "TOPLEFT", ChatFrame1, "TOPRIGHT", GAP, 0)
	SetupFrame(ChatFrame4, VSIZE/2 - GAP/2, HSIZE, 81, 14, 68, 119, "TOPLEFT", ChatFrame3, "BOTTOMLEFT", 0, -GAP)
	SetupFrame(ChatFrame6, VSIZE, HSIZE, 39, 65, 68, 112, "TOPLEFT", ChatFrame3, "TOPRIGHT", GAP, 0)
	FCF_Close(ChatFrame5)
	FCF_Close(ChatFrame7)

	FCF_SetLocked(ChatFrame1, true)
	FCF_SetLocked(ChatFrame3, true)
	FCF_SetLocked(ChatFrame4, true)
	FCF_SetLocked(ChatFrame6, true)


	WorldFrame:ClearAllPoints()
	WorldFrame:SetUserPlaced()
	WorldFrame:SetPoint("TOPRIGHT", UIParent)
	WorldFrame:SetPoint("LEFT", UIParent)
	WorldFrame:SetPoint("BOTTOM", ChatFrame1, "TOP", 0, GAP/2)
end)
