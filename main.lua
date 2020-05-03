require("base/GameManager");


player = GameObjects.Create("Player", 1);
player:AddComponent(Transform(Vector2.Initilize(0, 0)), 1);
player:AddComponent(SpriteRenderer(Vector2.Initilize(0,0),"player.bmp",3),2);
player:AddComponent(CollisionHandler(),3);
player:AddComponent(CollisionBox(Vector2.Initilize(40,40), Vector2.Initilize(0,0)),4);

player:AddBehavior(MoveBehavior(), 1);

enemy = GameObjects.Create("Enemy", 2);
enemy:AddComponent(Transform(Vector2.Initilize(100, 100)), 1);
enemy:AddComponent(SpriteRenderer(Vector2.Initilize(0,0),"enemy.bmp",2),2);
enemy:AddComponent(CollisionBox(Vector2.Initilize(40,40), Vector2.Initilize(0,0), "Enemy"),3);

function love.load()
	GameManager.Load();
	SoundManager:SetAmbiantSound("test.mp3")
	player.CollisionHandler:AddCollisionBehavior("Enemy", {PreventOverlap()})
end

function love.update(deltatime)
	GameManager.Update(deltatime);
end

function love.draw()
	GameManager.Draw();
end