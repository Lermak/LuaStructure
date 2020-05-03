CollisionManager = {}


function CollisionManager:Load()
  self.CollisionHandlers = {}
  self.CollisionBoxs = {}
end

function CollisionManager:Update(dt)
  CollisionManager:CheckCollision()
  for k,v in pairs(self.CollisionHandlers) do
    v:HandleCollisions(dt)
  end
end

function CollisionManager:AABBCollision(b1, b2)
  local x,y = 0,0
  if b1:TopLeft().x < b2:TopRight().x and--if box one overlaps with box 2
    b1:TopRight().x > b2:TopLeft().x and
    b1:TopRight().y < b2:BottomRight().y and
    b1:BottomRight().y > b2:TopRight().y then
      if b2:TopRight().x - b1:TopLeft().x  < b1:TopRight().x - b2:TopLeft().x then--get the smallest penitration value on the x axis
        x = b2:TopRight().x - b1:TopLeft().x
      else
        x = b1:TopRight().x - b2:TopLeft().x
      end

      if b1:BottomRight().y - b2:TopRight().y < b2:BottomRight().y - b1:TopRight().y then--get the smallest penitration value on the y axis
        y = b1:BottomRight().y - b2:TopRight().y
      else
        y = b2:BottomRight().y - b1:TopRight().y
      end
  end

  return Vector2.Initilize(x,y);
end

function CollisionManager:CheckCollision()
  for i=1, #self.CollisionBoxs do
    for x=i+1, #self.CollisionBoxs do
      local pen = self:AABBCollision(self.CollisionBoxs[i], self.CollisionBoxs[x])
      if pen.x ~= 0 and pen.y ~= 0 then
        --add the collision to the queue for both GameObject's collision handlers
        local ch = self.CollisionBoxs[i].GameObject.CollisionHandler
        if ch ~= nil then
          ch:AddCollision(pen, self.CollisionBoxs[x])
        end
        ch = self.CollisionBoxs[x].GameObject.CollisionHandler
        if ch ~= nil then
          ch:AddCollision(pen, self.CollisionBoxs[i])
        end
      end
    end
  end
end