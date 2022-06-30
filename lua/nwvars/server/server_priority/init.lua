util.AddNetworkString( "nwvars_ClientLoaded" )
util.AddNetworkString( "nwvars_InitNetworkVars" )

local function OnClientLoaded( _, pl )
	hook.Call( "OnPlayerLoaded", nil, pl )
end
net.Receive( "nwvars_ClientLoaded", OnClientLoaded )

local InitNetworkVars = {
	["TestFloat"] = { type = "Float", default =0.0 },
	["TestInt"] = { type = "Int", default = 0 },
	["TestBool"] = { type = "Bool", default = false },
	["TestString"] = { type = "String", default = "undefined" },
}

local function OnPlayerLoaded(pl)
	if !IsValid(pl) then return end

	pl.NWVars = {}
	pl.NWVars["Bool"] = {}
	pl.NWVars["Float"] = {}
	pl.NWVars["Int"] = {}
	pl.NWVars["String"] = {}

	for id, data in next, InitNetworkVars do
		pl.NWVars[data.type][id] = data.default
	end

	net.Start("nwvars_InitNetworkVars")
	net.WriteTable(pl.NWVars)
	net.Send(pl)

	print("[NWVARS] "..pl:Nick().." has successfully loaded.")
end
hook.Add( "OnPlayerLoaded", "NWVARS_SERVER_InitialSpawnReplacement", OnPlayerLoaded )