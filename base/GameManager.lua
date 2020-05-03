require("base/Vector2")
require("base/GameObject")
require("base/RenderingManager")
require("base/CollisionManager")
require("base/SoundManager")
require("base/ComponentDefinitions");
require("base/CollisionBehaviorDefinitions");
require("base/BehaviorDefinitions");


GameManager = {};


function GameManager.Load()
	GameManager.DeltaTime = 0
	SoundManager:Load()
	RenderingManager:Load()
	CollisionManager:Load()
	for i=1,#GameObjects do
		GameObjects[i]:Load();
	end
end

function GameManager.Update(dt)
	GameManager.DeltaTime = dt;
	for i=1,#GameObjects do
		GameObjects[i]:Update(dt);
	end
	CollisionManager:Update()
	RenderingManager:Update()
	SoundManager:Update()
end

function GameManager.Draw()
	RenderingManager:Draw()
end