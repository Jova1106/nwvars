print()

local category, File, init = "NWVARS", "nwvars-plugins.lua", "INITIALIZED"
local msg = string.format( "%s - %s | %s", category, File, init )
local file = file
local fileFind = file.Find
local fileIsDir = file.IsDir
local stringEndsWith = string.EndsWith
local stringformat = string.format
local AddCSLuaFile = AddCSLuaFile
local include = include
local print = print
local next = next

local sort_mode = "nameasc"

local CheckDirectories = {
	["shared"] = true,
	["server"] = true,
	["client"] = true
}

local function AddFiles( folder, path )
	if SERVER then
		if folder == "shared" then							
			include(path)
			AddCSLuaFile(path)
		elseif folder == "server" then
			include(path)
		elseif folder == "client" then
			AddCSLuaFile(path)
		end
	else
		include(path)
	end
end

local function LoadOrder(tbl)
	local loadOrder = {}
	
	if SERVER then
		for _, dir in next, tbl do
			if dir == "shared" then
				loadOrder[1] = dir
			elseif dir == "server" then
				loadOrder[2] = dir
			elseif dir == "client" then
				loadOrder[3] = dir
			end
		end
	elseif CLIENT then
		for _, dir in next, tbl do
			if dir == "shared" then
				loadOrder[1] = dir
			elseif dir == "client" then
				loadOrder[2] = dir
			end
		end
	end
	
	return loadOrder
end

function LoadPlugins(dir)
	dir = dir or "main"
	
	local _, pluginDirs = fileFind( stringformat( "%s/*", dir ), "LUA", sort_mode )
	
	pluginDirs = LoadOrder(pluginDirs)
	
	for n, folder in next, pluginDirs do		
		if fileIsDir( dir, "LUA" ) then			
			if CheckDirectories[folder] then
				local files, directories = fileFind( stringformat( "%s/%s/*", dir, folder ), "LUA", sort_mode )
				
				for _, d in next, directories do
					local sub_files, sub_directories = fileFind( stringformat( "%s/%s/%s/*", dir, folder, d ), "LUA", sort_mode )
					
					for k, f in next, sub_files do
						local path = stringformat( "%s/%s/%s/%s", dir, folder, d, f )
						
						if !stringEndsWith( path, ".lua" ) then continue end
						
						AddFiles( folder, path )
						
						print( stringformat( "%s - %s/[%s]: %s", category, folder, k, path ) )
					end
				end
				
				for k, f in next, files do
					local path = stringformat( "%s/%s/%s", dir, folder, f )
					
					if !stringEndsWith( path, ".lua" ) then continue end
					
					AddFiles( folder, path )
					
					print( stringformat( "%s - %s/%s: %s", category, folder, k, path ) )
				end
			end
			
			print()
		end
	end
end

LoadPlugins("nwvars")

print( msg )

print()