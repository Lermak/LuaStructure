Vector2 = {
}
Vector2.__index = Vector2

function Vector2.Initilize(x, y)
	local e = {};
	setmetatable(e, Vector2);
	e.x = x;
	e.y = y;
	return e;
end