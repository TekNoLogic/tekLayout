
local myname, ns = ...


local VSIZE = 150
local GAP = 6
local PADDING = 3
local LAPPY = UIParent:GetHeight() <= 900
local FONTSIZE = LAPPY and 13 or 11


local GROUPS = {
	[ChatFrame1] = {"BN_INLINE_TOAST_ALERT", "SYSTEM", "SYSTEM_NOMENU", "SAY",
	                "EMOTE", "MONSTER_SAY", "MONSTER_YELL", "MONSTER_EMOTE",
	                "MONSTER_WHISPER", "MONSTER_BOSS_EMOTE",
	                "MONSTER_BOSS_WHISPER", "ERRORS", "CHANNEL", "ACHIEVEMENT"},
	[ChatFrame3] = {"GUILD", "GUILD_OFFICER", "GUILD_ACHIEVEMENT"},
	[ChatFrame4] = {"BN_WHISPER", "BN_CONVERSATION", "WHISPER", "AFK", "DND",
	                "IGNORED", "PARTY", "PARTY_LEADER", "RAID", "RAID_LEADER",
	                "BG_HORDE", "BG_ALLIANCE", "BG_NEUTRAL", "BATTLEGROUND",
	                "BATTLEGROUND_LEADER", "RAID_WARNING", "INSTANCE_CHAT",
	                "INSTANCE_CHAT_LEADER"},
	[ChatFrame6] = {"COMBAT_FACTION_CHANGE", "SKILL", "LOOT", "MONEY", "CURRENCY",
	                "PET_INFO", "OPENING",
	                "COMBAT_XP_GAIN", "COMBAT_HONOR_GAIN", "COMBAT_MISC_INFO"},
}


local function SetupFrame(frame, h, w, r, g, b, a, ...)
	local id = frame:GetID()

	if frame ~= ChatFrame1 then
		SetChatWindowDocked(id, nil)
		for i,v in pairs(DOCKED_CHAT_FRAMES) do
			if v == frame then table.remove(DOCKED_CHAT_FRAMES, i) end
		end
		frame.isDocked = nil

		frame.isLocked = nil
		SetChatWindowLocked(id, nil)
	end

	frame:ClearAllPoints()
	frame:SetPoint(...)
	frame:Setsize(w, h)
	frame:Show()

	FCF_SetWindowColor(frame, r/255, g/255, b/255)
	FCF_SetWindowAlpha(frame, a/255)

	local font, _, flags = frame:GetFont()
	frame:SetFont(font, FONTSIZE, flags)
	SetChatWindowSize(id, FONTSIZE)

	ChatFrame_RemoveChannel(frame, "General")
	ChatFrame_RemoveAllMessageGroups(frame)
	for i,v in pairs(GROUPS[frame]) do ChatFrame_AddMessageGroup(frame, v) end
end


local function OnLogin()
	local HSIZE = UIParent:GetWidth()/3-PADDING*2


	-- Force on raid coloring
	for i,v in pairs(CHAT_CONFIG_CHAT_LEFT) do
		ToggleChatColorNamesByClassGroup(true, v.type)
	end


	SetupFrame(ChatFrame1, VSIZE, HSIZE, 51, 51, 51, 107, "BOTTOMLEFT", UIParent, PADDING, PADDING*2 + 3)
	ChatFrame1.SetPoint = function() end -- Wrath build 8820 started resetting ChatFrame1's position.  This ensures it doesn't fuck with my layout.
	SetupFrame(ChatFrame3, VSIZE/2 - PADDING, HSIZE, 5, 70, 6, 91, "TOPLEFT", ChatFrame1, "TOPRIGHT", PADDING*2, 0)
	SetupFrame(ChatFrame4, VSIZE/2 - PADDING, HSIZE, 81, 14, 68, 119, "TOPLEFT", ChatFrame3, "BOTTOMLEFT", 0, -PADDING*2)
	SetupFrame(ChatFrame6, VSIZE, HSIZE, 39, 65, 68, 112, "TOPLEFT", ChatFrame3, "TOPRIGHT", PADDING*2, 0)
	FCF_Close(ChatFrame5)
	FCF_Close(ChatFrame7)

	FCF_SetLocked(ChatFrame1, true)
	FCF_SetLocked(ChatFrame3, true)
	FCF_SetLocked(ChatFrame4, true)
	FCF_SetLocked(ChatFrame6, true)
end


ns.RegisterCallback("PLAYER_LOGIN", OnLogin)
