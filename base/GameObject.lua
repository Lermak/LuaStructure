GameObjects = {};

GameObject = {
};
GameObject.__index = GameObject

function GameObjects.Create(n, uo)
	local ID = 0;

	if GameObject[uo] ~= nil then
		error("Update Order " .. uo .. " for game object " .. n .. " is already used");
	end
	
	local e = {};
	setmetatable(e, GameObject);

	e.GameObjectID = #GameObjects + 1;
	e.Name = n;
	e.Behaviors = {};
	e.Components = {};
	
	GameObjects[uo] = e;
	return GameObjects[uo];
end

function GameObject:AddComponent(c, lo)
	if self.Components[lo] == nil then
		c.GameObject = self;
		self.Components[lo] = c;
	else
		error("Load Order " .. lo .. " for component " .. c.Name .." on game object " .. self.Name .. " is already used");
	end

	return self.Components[#self.Components];
end

function GameObject:AddBehavior(b, uo)
	if self.Behaviors[uo] == nil then
		b.GameObject = self;
		self.Behaviors[uo] = b;
	else
		error("Update Order " .. uo .. " for behavior " .. b.Name .." on game object " .. self.Name .. " is already used");
	end
	
	return self.Behaviors[uo];
end

function GameObject:Load()
	for k,v in pairs(self.Components) do
		if v ~= nil then
			if v.Load ~= nil then
				v:Load();
			end
		end
	end
end

function GameObject:Update(dt)
	for k, v in pairs(self.Behaviors) do
		if v ~= nil then
			v:Run(dt);
		end
	end
end