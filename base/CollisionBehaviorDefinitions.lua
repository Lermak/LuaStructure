function PreventOverlap()
  local e={
    soundCooldown = 1,
    sinceLastSound = 1
  }
  function e:Run(pen, box)
    --test code for sound effects
    self.sinceLastSound = self.sinceLastSound + GameManager.DeltaTime
    if self.sinceLastSound >= self.soundCooldown then
      self.sinceLastSound = 0
      SoundManager:AddSound("hurt1.ogg")
    end
    local moveDir = pen
    if moveDir.x < moveDir.y then -- if my x penitration is smaller than my y penitration then I most likely only need to adjust in the x axis
      moveDir.y = 0
    else
      moveDir.x = 0
    end

    if self.GameObject.Transform.Position.x < box.GameObject.Transform.Position.x then-- if my objcect is to the left
      moveDir.x = pen.x * -1 --move left
    end
    if self.GameObject.Transform.Position.y < box.GameObject.Transform.Position.y then-- if my objcect is above
      moveDir.y = pen.y * -1--move up
    end

    for k, v in pairs(self.GameObject.CollisionBoxs) do
      self.GameObject.CollisionBox:Move(moveDir)
    end
    self.GameObject.Transform:Move(moveDir.x, moveDir.y)
  end

  return e;
end