print()

local root_folder_name = debug.getinfo(1).short_src:match("addons/(.-)/")
local file_Find = file.Find
local AddCSLuaFile = AddCSLuaFile
local include = include
local print = print
local next = next
local sort_mode = "nameasc"
local files_to_add = {}
local files_to_skip = {}
local SERVER, CLIENT = SERVER, CLIENT
local realm_load_order = {"shared", "server", "client"}

if SERVER then
	files_to_add.shared = {}
	files_to_add.server = {}
	files_to_add.client = {}
elseif CLIENT then
	files_to_add.shared = {}
	files_to_add.client = {}
end

local function RunFile(file_path)
	local file = file_path:match(".+/(.+)")
	
	if !file:EndsWith(".lua") then return end
	
	if SERVER then
		if file:StartWith("_sh_") or file:StartWith("sh_") then
			AddCSLuaFile(file_path)
			include(file_path)
		elseif file:StartWith("_sv_") or file:StartWith("sv_") then
			include(file_path)
		elseif file:StartWith("_cl_") or file:StartWith("cl_") then
			AddCSLuaFile(file_path)
		end
	elseif CLIENT then
		if file:StartWith("_sh_") or file:StartWith("sh_") then
			include(file_path)
		elseif file:StartWith("_cl_") or file:StartWith("cl_") then
			include(file_path)
		end
	end
	
	print(("%s -> %s"):format(root_folder_name, file_path))
end

local function AddFile(file_path)
	local file = file_path:match(".+/(.+)")
	
	if !file:EndsWith(".lua") then return end
	
	local file_path_no_file = file_path:match(".+/")
	
	if file == "module_init.lua" then		
		if SERVER then
			AddCSLuaFile(file_path)
		end
		
		local module_init = include(file_path)
		
		print(("%s -> %s"):format(root_folder_name, file_path))
		
		for i = 1, #module_init do
			local file = module_init[i]
			local new_path = file_path_no_file.."/"..file
			
			files_to_skip[new_path] = true
			
			RunFile(new_path)
		end
	elseif SERVER then
		if file:StartWith("_sh_") or file:StartWith("sh_") then
			table.insert(files_to_add.shared, file_path)
		elseif file:StartWith("_sv_") or file:StartWith("sv_") then
			table.insert(files_to_add.server, file_path)
		elseif file:StartWith("_cl_") or file:StartWith("cl_") then
			table.insert(files_to_add.client, file_path)
		end
	elseif CLIENT then
		if file:StartWith("_sh_") or file:StartWith("sh_") then
			table.insert(files_to_add.shared, file_path)
		elseif file:StartWith("_cl_") or file:StartWith("cl_") then
			table.insert(files_to_add.client, file_path)
		end
	end
end

function LoadFiles(file_path, recursive_path)
	recursive_path = recursive_path or false
	file_path = file_path or root_folder_name
	local files, folders = file_Find(file_path.."/*", "LUA")

	if !table.IsEmpty(folders) then
		for _, folder_name in next, folders do
			if folder_name == "." or folder_name == ".." then continue end
			
			local path = ("%s/%s"):format(file_path, folder_name)
			
			LoadFiles(path, true)
		end
	end

	if !table.IsEmpty(files) then
		for i = 1, #files do
			local file = files[i]
			
			if !recursive_path then
				RunFile(file_path.."/"..file)
			else
				AddFile(file_path.."/"..file)
			end
		end
	end
	
	if !recursive_path then
		for _, realm in next, realm_load_order do
			if CLIENT and realm == "server" then continue end
			
			for _, path in next, files_to_add[realm] do
				if files_to_skip[path] then continue end
				
				RunFile(path)
			end
		end
		
		files_to_add, files_to_skip = nil, nil
	end
end

LoadFiles()

print()