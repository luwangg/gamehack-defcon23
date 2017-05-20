if SERVER then
	include("sv_init.lua")
	AddCSLuaFile("cl_init.lua")
	AddCSLuaFile("base64.lua")
else
    include("cl_init.lua")
end
