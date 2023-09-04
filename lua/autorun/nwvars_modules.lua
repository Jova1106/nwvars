print()

local root_folder_name = debug.getinfo(1).short_src:match("addons/(.-)/")

local function RunFile(file_path)
	local file = file_path:match(".+/(.+)")
	
	if !file:match("(.lua)$") then return end
	
	if SERVER then
		if file:match("^_*(sh_)") then
			AddCSLuaFile(file_path)
			include(file_path)
		elseif file:match("^_*(sv_)") then
			include(file_path)
		elseif file:match("^_*(cl_)") then
			AddCSLuaFile(file_path)
		end
	elseif CLIENT then
		if file:match("^_*(sh_)") then
			include(file_path)
		elseif file:match("^_*(cl_)") then
			include(file_path)
		end
	end
	
	print(("%s -> %s"):format(root_folder_name, file_path))
end

function LoadFiles(file_path)
	file_path = file_path or root_folder_name
	local files, folders = file.Find(file_path.."/*", "LUA")
	
	if !table.IsEmpty(folders) then
		for _, folder_name in next, folders do
			if folder_name == "." or folder_name == ".." then continue end
			
			local path = ("%s/%s"):format(file_path, folder_name)
			
			LoadFiles(path)
		end
	end
	
	if !table.IsEmpty(files) then
		for i = 1, #files do
			local file = files[i]
			
			RunFile(file_path.."/"..file)
		end
	end
end

LoadFiles()

print()