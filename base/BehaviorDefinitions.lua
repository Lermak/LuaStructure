function MoveBehavior()
	local e = {
	};
	function e:Run(dt)
		if love.keyboard.isDown('up') then self.GameObject.Transform:Move(0,-(50*dt)) end
		if love.keyboard.isDown('down') then self.GameObject.Transform:Move(0,(50*dt)) end
		if love.keyboard.isDown('left') then self.GameObject.Transform:Move(-(50*dt), 0) end
		if love.keyboard.isDown('right') then self.GameObject.Transform:Move((50*dt), 0) end
	end;

	return e;
end
