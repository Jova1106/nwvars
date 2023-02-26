local PLAYER = FindMetaTable("Player")
local LocalPlayer = LocalPlayer
local tonumber = tonumber

net.Receive("nwvars_NWBool", function()
	if !IsValid(LocalPlayer()) or !LocalPlayer().NWVars then return end
	local id = net.ReadString()
	local bool = net.ReadBool()
	
	LocalPlayer().NWVars["Bool"][id] = bool
end)

net.Receive("nwvars_NWFloat", function()
	if !IsValid(LocalPlayer()) or !LocalPlayer().NWVars then return end
	local id = net.ReadString()
	local float = net.ReadFloat()
	
	LocalPlayer().NWVars["Float"][id] = float
end)

net.Receive("nwvars_NWInt", function()
	if !IsValid(LocalPlayer()) or !LocalPlayer().NWVars then return end
	local id = net.ReadString()
	local size = tonumber(net.ReadString())
	local int = net.ReadInt(size)
	
	LocalPlayer().NWVars["Int"][id] = int
end)

net.Receive("nwvars_NWString", function()
	if !IsValid(LocalPlayer()) or !LocalPlayer().NWVars then return end
	local id = net.ReadString()
	local str = net.ReadString()
	
	LocalPlayer().NWVars["String"][id] = str
end)

net.Receive("nwvars_NWTable", function()
	if !IsValid(LocalPlayer()) or !LocalPlayer().NWVars then return end
	local id = net.ReadString()
	local tbl = net.ReadTable()
	
	LocalPlayer().NWVars["Table"][id] = tbl
end)

net.Receive("nwvars_NWAngle", function()
	if !IsValid(LocalPlayer()) or !LocalPlayer().NWVars then return end
	local id = net.ReadString()
	local ang = net.ReadAngle()
	
	LocalPlayer().NWVars["Angle"][id] = ang
end)