"# LuaStructure" 
The core strucure of this application is based on creating GameObjects and then applying Components and Behaviors to that object

Building game objects looks like the following:

The initialization of the GameObject, passing the name of the object as well as the update order
player = GameObjects.Create("Player", 1);

Adding a component to the object calls the AddComponent method passing in a table as well as the Load order
player:AddComponent(Transform(Vector2.Initilize(0, 0)), 1);

Adding a behavior to an object calls the AddBehavior method passing in a table as well as the update order
player:AddBehavior(MoveBehavior(), 1);

Components will have a Load function to set the default values and setup anything needed, that will be called at the start of the game.

Behaviors will have a Run function and no Load function. The Run function will be called each game loop for every behavior on the object

If an object has a CollisionHandler component you may add collision events in the following way:

The first argument will be a name that the colliding collision box needs to have to perform these actions, the second is a table of tables
that have a Run function that take in a Vector2 and CollisionBox object
player.CollisionHandler:AddCollisionBehavior("Enemy", {PreventOverlap()})