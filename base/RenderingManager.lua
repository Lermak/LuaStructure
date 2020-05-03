RenderingManager = {}

function RenderingManager:Load()
  RenderingManager.renderList = {}
  RenderingManager.renderShapeList = {}
  RenderingManager.hudList = {}
  RenderingManager.vectorList = {}
end

function RenderingManager:Update()

end

function RenderingManager:Draw()
  for i,j in pairs(RenderingManager.renderList) do
    for k,v in pairs(RenderingManager.renderList[i]) do
      love.graphics.draw(v.Sprite, v.GameObject.Transform.Position.x + v.Position.x, v.GameObject.Transform.Position.y + v.Position.y)
    end
  end
end