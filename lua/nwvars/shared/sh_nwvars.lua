local PLAYER = FindMetaTable("Player")

function PLAYER:getNWFloat(id)
	if !IsValid(self) then return end
	
	return self.NWVars and self.NWVars["Float"] and self.NWVars["Float"][id] or 0
end

function PLAYER:getNWInt(id)
	if !IsValid(self) then return end
	
	return self.NWVars and self.NWVars["Int"] and self.NWVars["Int"][id] or 0
end

function PLAYER:getNWBool(id)
	if !IsValid(self) then return end
	
	return self.NWVars and self.NWVars["Bool"] and self.NWVars["Bool"][id] or false
end

function PLAYER:getNWString(id)
	if !IsValid(self) then return end
	
	return self.NWVars and self.NWVars["String"] and self.NWVars["String"][id] or "undefined"
end

function PLAYER:getNWTable(id)
	if !IsValid(self) then return end
	
	return self.NWVars and self.NWVars["Table"] and self.NWVars["Table"][id] or {}
end

function PLAYER:getNWAngle(id)
	if !IsValid(self) then return end
	
	return self.NWVars and self.NWVars["Angle"] and self.NWVars["Angle"][id] or {}
end