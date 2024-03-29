util.AddNetworkString("nwvars_ClientLoaded")
util.AddNetworkString("nwvars_InitNetworkVars")
util.AddNetworkString("nwvars_NWBool")
util.AddNetworkString("nwvars_NWFloat")
util.AddNetworkString("nwvars_NWInt")
util.AddNetworkString("nwvars_NWString")
util.AddNetworkString("nwvars_NWTable")
util.AddNetworkString("nwvars_NWAngle")

local function OnClientLoaded( _, pl )
	hook.Call( "OnPlayerLoaded", nil, pl )
end
net.Receive( "nwvars_ClientLoaded", OnClientLoaded )

local angle_0 = Angle(0,0,0)

local Default = {
	["Bool"] = false,
	["Float"] = 0.0,
	["Int"] = 0,
	["String"] = "undefined",
	["Table"] = {},
	["Angle"] = angle_0
}

local NetworkVars = {
	["TestBool"] = {type = "Bool", default = false},
	["TestFloat"] = {type = "Float", default = 0.0},
	["TestInt"] = {type = "Int", default = 0},
	["TestString"] = {type = "String", default = "undefined"},
	["TestTable"] = {type = "Table", default = {}},
	["TestAngle"] = {type = "Angle", default = angle_0}
}

local function InitNetworkVars(pl)
	pl.NWVars = {}
	pl.NWVars["Bool"] = {}
	pl.NWVars["Float"] = {}
	pl.NWVars["Int"] = {}
	pl.NWVars["String"] = {}
	pl.NWVars["Table"] = {}
	pl.NWVars["Angle"] = {}
	
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