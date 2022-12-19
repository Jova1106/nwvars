local function OnPlayerLoaded()
	net.Start("nwvars_ClientLoaded")
	net.SendToServer()
end
hook.Add( "InitPostEntity", "NWVARS_CLIENT_InitialSpawnReplacement", OnPlayerLoaded )

net.Receive( "nwvars_InitNetworkVars", function()
	local pl = LocalPlayer()
	if !IsValid(pl) then return end
	local tbl = net.ReadTable()
	
	pl.NWVars = tbl
end )