local PLAYER = FindMetaTable("Player")

function PLAYER:setNWBool( id, bool )
    if !IsValid(self) or !self.NWVars then return end

    self.NWVars["Bool"][id] = bool

    net.Start("nwvars_NWBool")
    net.WriteString(id)
    net.WriteBool(bool)
    net.Send(self)
end

function PLAYER:setNWFloat( id, float )
    if !IsValid(self) or !self.NWVars then return end

    self.NWVars["Float"][id] = float

    net.Start("nwvars_NWFloat")
    net.WriteString(id)
    net.WriteFloat(float)
    net.Send(self)
end

function PLAYER:setNWInt( id, value, size )
    if !IsValid(self) or !self.NWVars then return end
    local size = size or 10

    self.NWVars["Int"][id] = value

    net.Start("nwvars_NWInt")
    net.WriteString(id)
    net.WriteString(tostring(size))
    net.WriteInt(value, size)
    net.Send(self)
end

function PLAYER:setNWString( id, str )
    if !IsValid(self) or !self.NWVars then return end
    
    self.NWVars["String"][id] = str
    
    net.Start("nwvars_NWString")
    net.WriteString(id)
    net.WriteString(str)
    net.Send(self)
end