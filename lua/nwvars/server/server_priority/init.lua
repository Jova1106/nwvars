util.AddNetworkString("nwvars_ClientLoaded")
util.AddNetworkString("nwvars_InitNetworkVars")
util.AddNetworkString("nwvars_NWBool")
util.AddNetworkString("nwvars_NWFloat")
util.AddNetworkString("nwvars_NWInt")
util.AddNetworkString("nwvars_NWString")

local function OnClientLoaded( _, pl )
	hook.Call( "OnPlayerLoaded", nil, pl )
end
net.Receive( "nwvars_ClientLoaded", OnClientLoaded )

local Default = {
	["Bool"] = false,
	["Float"] = 0.0,
	["Int"] = 0,
	["String"] = "undefined"
}

local NetworkVars = {
	["TestBool"] = { type = "Bool", default = false },
	["TestFloat"] = { type = "Float", default = 0.0 },
	["TestInt"] = { type = "Int", default = 0 },
	["TestString"] = { type = "String", default = "undefined" },
}

local function InitNetworkVars(pl)
	pl.NWVars = {}
	pl.NWVars["Bool"] = {}
	pl.NWVars["Float"] = {}
	pl.NWVars["Int"] = {}
	pl.NWVars["String"] = {}
	
	for id, data in next, NetworkVars do
		pl.NWVars[data.type][id] = data.default or Default[data.type]
	end
	
	net.Start("nwvars_InitNetworkVars")
	net.WriteTable(pl.NWVars)
	net.Send(pl)
end

local function OnPlayerLoaded(pl)
	if !IsValid(pl) then return end
	
	InitNetworkVars(pl)
	
	print("[NWVARS] "..pl:Nick().." has successfully loaded.")
end
hook.Add( "OnPlayerLoaded", "NWVARS_SERVER_InitialSpawnReplacement", OnPlayerLoaded )