local PLAYER = FindMetaTable("Player")
local LocalPlayer = LocalPlayer
local tonumber = tonumber

net.Receive( "NWFloat", function()
	if !IsValid(LocalPlayer()) or !LocalPlayer().NWVars then return end
    local id = net.ReadString()
    local float = net.ReadFloat()
    
    LocalPlayer().NWVars["Float"][id] = float
end )

net.Receive( "NWInt", function()
	if !IsValid(LocalPlayer()) or !LocalPlayer().NWVars then return end
    local id = net.ReadString()
    local size = tonumber(net.ReadString())
    local int = net.ReadInt(size)
    
    LocalPlayer().NWVars["Int"][id] = int
end )

net.Receive( "NWBool", function()
	if !IsValid(LocalPlayer()) or !LocalPlayer().NWVars then return end
    local id = net.ReadString()
    local bool = net.ReadBool()
    
    LocalPlayer().NWVars["Bool"][id] = bool
end )

net.Receive( "NWString", function()
	if !IsValid(LocalPlayer()) or !LocalPlayer().NWVars then return end
    local id = net.ReadString()
    local str = net.ReadString()
    
    LocalPlayer().NWVars["String"][id] = str
end )