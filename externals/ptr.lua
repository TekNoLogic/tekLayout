
local myname, ns = ...


local function ParseVersion(version)
	assert(version, "version must not be nil")

	local major, minor, patch = string.split(".", version)

	major = tonumber(major)
	assert(major, string.format("Error parsing major version from %q", version))

	minor = tonumber(minor)
	assert(minor, string.format("Error parsing minor version from %q", version))

	patch = patch or "0"
	patch = tonumber(patch)
	assert(patch, string.format("Error parsing patch version from %q", version))

	return major, minor, patch
end


-- Check a version string against the current game version.  Returns true if the
-- game version is *at least* the version specified.
--
-- Args:
--  * version - a version string with major and minor, and optional patch
--         ex: "7.1.0" or "6.0"
function ns.IsGameVersion(version)
	local major, minor, patch = ParseVersion(version)
	local game_major, game_minor, game_patch = ParseVersion((GetBuildInfo()))

	if game_major > major then return true end
	if game_major < major then return false end

	if game_minor > minor then return true end
	if game_minor < minor then return false end

	if game_patch >= patch then return true end
	if game_patch < patch then return false end
end


ns.is_7_1 = ns.IsGameVersion("7.1")
