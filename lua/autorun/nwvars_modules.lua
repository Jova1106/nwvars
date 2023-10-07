print()

local root_folder_name = debug.getinfo(1).short_src:match("addons/(.-)/")

local function PrintFile(file_path)
	print(("%s -> %s"):format(root_folder_name, file_path))
end

local function RunFile(file_path)
	local file = file_path:match(".+/(.+)")
	
	if !file:match("(.lua)$") then return end
	
	local is_shared = file:match("^_*(sh_)")
	local is_server = file:match("^_*(sv_)")
	local is_client = file:match("^_*(cl_)")
	
	if SERVER then		
		if is_shared then
			AddCSLuaFile(file_path)
			include(file_path)
		elseif is_server then
			include(file_path)
		elseif is_client then
			AddCSLuaFile(file_path)
		end
		
		if is_shared or is_server or is_client then
			PrintFile(file_path)
		end
	elseif CLIENT then
		if is_shared then
			include(file_path)
		elseif is_client then
			include(file_path)
		end
		
		if is_shared or is_client then
			PrintFile(file_path)
		end
	end
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

LoadFiles("nwvars")

print()