function SpriteRenderer(pos,img, zo)
	local e = {
		Position = pos;
		Sprite = love.graphics.newImage('assets/Sprites/' .. img);
		Name = "SpriteRenderer";
	};
	
	function e:Load()
	
		if self.GameObject.SpriteRenderer == nil then
			self.GameObject.SpriteRenderer = {};
		end

		self.GameObject.SpriteRenderer[#self.GameObject.SpriteRenderer + 1] = self;

		if RenderingManager.renderList[zo] == nil then
			RenderingManager.renderList[zo] = {}
		end

		RenderingManager.renderList[zo][#RenderingManager.renderList[zo] + 1] = self
		RenderingManager.needReorder = true
	end;

	return e;
end

function Transform(pos)
	local e = {
		Position = pos;
		Name = "Transform";
	};

	function e:Load()
		if self.GameObject.Transform ~= nil then
			error("Transform already exists on Game Object " .. self.GameObject.Name);		
		else
			self.GameObject.Transform = self;
		end
	end;

	function e:Move(x,y)
		self.Position.x = self.Position.x + x;
		self.Position.y = self.Position.y + y;
	end

	return e;
end

function CollisionBox(size, os, name)
	local CollisionBox = {
		Offset = os or Vector2.Initilize();
		Size = size or Vector2.Initilize();
		Name = name or  "CollisionBox";
	}

	function CollisionBox:Load()
		--if this is an object's first collision box, make it's collision box table
		if self.GameObject.CollisionBoxs == nil then
			self.GameObject.CollisionBoxs = {};
		end
		CollisionManager.CollisionBoxs[#CollisionManager.CollisionBoxs + 1] = self
	end

	-- Redefine Box size
	function CollisionBox:Resize(Width, Height)
		self.Size.x = Width;
		self.Size.y = Height;
	end

	-- Functions to return the spefified corner of the box
	function CollisionBox:TopLeft()
		local result = Vector2.Initilize();
		result.x = self.GameObject.Transform.Position.x + self.Offset.x;
		result.y = self.GameObject.Transform.Position.y + self.Offset.y;
		return result;
	end

	function CollisionBox:TopRight()
		local result = Vector2.Initilize();
		result.x = self.GameObject.Transform.Position.x + self.Size.x + self.Offset.x;
		result.y = self.GameObject.Transform.Position.y + self.Offset.y;
		return result;
	end

	function CollisionBox:BottomLeft()
		local result = Vector2.Initilize();
		result.x = self.GameObject.Transform.Position.x + self.Offset.x;
		result.y = self.GameObject.Transform.Position.y + self.Size.y + self.Offset.y;
		return result;
	end

	function CollisionBox:BottomRight()
		local result = Vector2.Initilize();
		result.x = self.GameObject.Transform.Position.x + self.Size.x + self.Offset.x;
		result.y = self.GameObject.Transform.Position.y + self.Size.y + self.Offset.y;
		return result;
	end

	-- Alter the center point of the box
	function CollisionBox:Move(dist)
		self.center.x = self.center.x + dist.x;
		self.center.y = self.center.y + dist.y;
	end

	return CollisionBox;
end

function CollisionHandler()
	local CollisionHandler = {};

	function CollisionHandler:AddCollision(pen, box)
		self.Collisions[#self.Collisions+1] = {p = pen, b = box}
	end

	function CollisionHandler:Load()
		if self.GameObject.CollisionHandler ~= nil then
			error("CollisionHandler already exists on Game Object " .. self.GameObject.Name);		
		else
			self.GameObject.CollisionHandler = self;
		end
		CollisionManager.CollisionHandlers[#CollisionManager.CollisionHandlers + 1] = self

		self.Collisions = {}
		self.CollisionBehaviors = {}
	end;

	--add a collision box to interact with
	function CollisionHandler:AddCollisionBehavior(n,a)
		for k,v in pairs(a) do
			v.GameObject = self.GameObject--associate my gameobject with all behaviors
		end
		self.CollisionBehaviors[#self.CollisionBehaviors+1] = {Name = n; Actions = a;};--the name of the collision box to perform this action on and the action to perform
	end

	function CollisionHandler:HandleCollisions(dt)
		for k,v in pairs(self.Collisions) do--for each of my collisions
			for i, x in pairs(self.CollisionBehaviors) do--check if it is an object in my list of collidables with events
				if x.Name == v.b.Name then -- is the name correct and are they not part of the same object
					for q, z in pairs(x.Actions) do--run all events associated with collisions that have the same name				
						z:Run(v.p, v.b)--run the collision behavior passing in the penitration value and the box collided with
					end
				end
			end
		end
		self.Collisions = {}
	end

	return CollisionHandler;
end
